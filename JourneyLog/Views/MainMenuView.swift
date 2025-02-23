//
//  MainMenuView.swift
//  JourneyLog
//
//  Created by Oscar Angulo on 2/22/25.
//

import SwiftUI

struct MainMenuView: View {
    var body: some View {
        NavigationView {
            HStack {
                NavigationLink(destination: SignInView()) {
                    Text("Log In")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                NavigationLink(destination: SignUpView()) {
                    Text("Sign Up")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
    }
}

#Preview {
    MainMenuView()
}
