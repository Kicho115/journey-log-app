//
//  LoginService.swift
//  JourneyLog
//
//  Created by Oscar Angulo on 2/21/25.
//

import SwiftUI
import FirebaseAuth

struct SignInView: View {
    @StateObject var authViewModel = UserViewModel()
    @State private var email = ""
    @State private var password = ""
    @State private var isLoading = false
    @State private var showSuccessMessage = false

    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            if isLoading {
                ProgressView("Signing in...")
            } else {
                Button("Sign In") {
                    isLoading = true
                    authViewModel.signIn(email: email, password: password)
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }

            if let errorMessage = authViewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray)
        .onChange(of: authViewModel.isLoggedIn) { newValue in
            if newValue {
                isLoading = false
                showSuccessMessage = true
            }
        }
        .fullScreenCover(isPresented: $authViewModel.isLoggedIn) {
            if let user = authViewModel.user {
                HomeView(userViewModel: authViewModel, userId: user.id)
            }
        }
    }
}

#Preview {
    SignInView()
}
