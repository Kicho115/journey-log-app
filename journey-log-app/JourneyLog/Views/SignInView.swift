//
//  LoginService.swift
//  JourneyLog
//
//  Created by Oscar Angulo on 2/21/25.
//

import SwiftUI
import FirebaseAuth

struct SignInView: View {
    @StateObject var authViewModel = AuthViewModel()
    @State private var email = ""
    @State private var password = ""
    

    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button("Sign In") {
                authViewModel.signIn(email: email, password: password)
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)

            if let errorMessage = authViewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray)
        .fullScreenCover(isPresented: $authViewModel.isLoggedIn) {
            //HomeView() // TODO: create homeview
            MainMenuView()
        }
    }
}

#Preview {
    SignInView()
}
