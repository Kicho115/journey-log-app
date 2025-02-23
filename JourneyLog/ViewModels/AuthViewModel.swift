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
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
    
    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
}
