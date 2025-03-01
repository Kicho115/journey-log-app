//
//  AuthViewModel.swift
//  JourneyLog
//
//  Created by Oscar Angulo on 2/22/25.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import Combine

class UserViewModel: ObservableObject {
    @Published var isLoggedIn = false
    @Published var errorMessage: String?
    @Published var user: User?
    @Published var userLogs: [Log] = []

    private let db = Firestore.firestore()

    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
                self.isLoggedIn = false
            } else {
                self.errorMessage = nil
                self.isLoggedIn = true
                if let userId = Auth.auth().currentUser?.uid {
                    self.fetchUser(userId: userId)
                }
            }
        }
    }

    func signUp(email: String, password: String, name: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print(error.localizedDescription)
            }
            if let user = result?.user {
                let userData = [
                    "id": user.uid,
                    "email": email,
                    "name": name
                ]
                self.db.collection("Users").document(user.uid).setData(userData) { error in
                    if let error = error {
                        print("Error saving user: \(error.localizedDescription)")
                    } else {
                        print("User saved successfully")
                    }
                }
            }
        }
    }

    func fetchUser(userId: String, completion: ((Error?) -> Void)? = nil) {
        db.collection("Users").document(userId).getDocument { document, error in
            if let document = document, document.exists {
                if let data = document.data() {
                    print("User data: ", data)
                    self.user = User(id: document.documentID, data: data)
                    self.fetchUserLogs(userId: document.documentID)
                }
                completion?(nil)
            } else {
                print("User not found: \(error?.localizedDescription ?? "Unknown error")")
                completion?(error)
            }
        }
    }

    func fetchUserLogs(userId: String) {
        db.collection("Users").document(userId).collection("Logs").getDocuments { snapshot, error in
            if let snapshot = snapshot {
                self.userLogs = snapshot.documents.map { doc in
                    print("Log:", doc)
                    return Log(id: doc.documentID, data: doc.data())
                }
            } else {
                print("Error fetching user logs: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }

    func checkAuthStatus() {
        if Auth.auth().currentUser != nil {
            self.isLoggedIn = true
            if let userId = Auth.auth().currentUser?.uid {
                fetchUser(userId: userId)
            }
        } else {
            self.isLoggedIn = false
        }
    }
    
    func addLog(title: String, description: String, imageUrl: String? = nil, location: GeoPoint? = nil, completion: ((Error?) -> Void)? = nil) {
            guard let userId = Auth.auth().currentUser?.uid else {
                completion?(NSError(domain: "Auth", code: -1, userInfo: [NSLocalizedDescriptionKey: "Usuario no autenticado"]))
                return
            }

            guard !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
                  !description.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                completion?(NSError(domain: "Validation", code: -2, userInfo: [NSLocalizedDescriptionKey: "Título y descripción no pueden estar vacíos"]))
                return
            }

            let logData: [String: Any] = [
                "title": title,
                "description": description,
                "imageUrl": imageUrl as Any,
                "location": location as Any,
                "createdAt": Timestamp(date: Date())
            ]

            db.collection("Users").document(userId).collection("Logs").addDocument(data: logData) { error in
                if let error = error {
                    print("Error adding log: \(error.localizedDescription)")
                    completion?(error)
                } else {
                    print("Log added successfully")
                    self.fetchUserLogs(userId: userId)
                    completion?(nil)
                }
            }
        }

    func signOut() {
        do {
            try Auth.auth().signOut()
            self.isLoggedIn = false
            self.user = nil
            self.userLogs = []
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
}
