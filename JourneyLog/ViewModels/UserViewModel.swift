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
