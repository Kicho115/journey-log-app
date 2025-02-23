//
//  AuthViewModel.swift
//  JourneyLog
//
//  Created by Oscar Angulo on 2/22/25.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

// TODO: Store the user data in firestore
class AuthViewModel: ObservableObject {
    @Published var isLoggedIn = false
    @Published var errorMessage: String?
    
    private let db = Firestore.firestore()
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                self.errorMessage = error!.localizedDescription
                self.isLoggedIn = false
            } else {
                self.errorMessage = nil
                self.isLoggedIn = true
            }
        }
    }
    
    func signUp(email: String, password: String, name: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            // Save the data to firestore
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
                        print("User saved succesfully")
                    }
                }
            }
        }
    }
}
