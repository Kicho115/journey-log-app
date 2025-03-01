import SwiftUI
import FirebaseAuth

struct SignInView: View {
    @StateObject var authViewModel = UserViewModel()
    @State private var email = ""
    @State private var password = ""
    @State private var isLoading = false
    @State private var showSuccessMessage = false

    let lightBrown = Color(red: 222/255, green: 184/255, blue: 135/255)
    let darkBrown = Color(red: 139/255, green: 69/255, blue: 19/255)
    let lightMediumBrown = Color(red: 205/255, green: 133/255, blue: 63/255)
    let lighterBrown = Color(red: 245/255, green: 222/255, blue: 179/255)

    var body: some View {
        ZStack {
            darkBrown.ignoresSafeArea()

            // Círculos de fondo
            GeometryReader { geometry in
                Circle()
                    .fill(lightBrown.opacity(0.4))
                    .frame(width: geometry.size.width * 0.9)
                    .position(x: geometry.size.width * 0.1, y: geometry.size.height * 0.2)

                Circle()
                    .fill(lightMediumBrown.opacity(0.6))
                    .frame(width: geometry.size.width * 0.8)
                    .position(x: geometry.size.width * 0.8, y: geometry.size.height * 0.8)

                Circle()
                    .fill(lighterBrown.opacity(0.5))
                    .frame(width: geometry.size.width * 0.8)
                    .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.5)
            }

            VStack {
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()
                    .background(lightBrown)
                    .cornerRadius(10)

                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .background(lightBrown)
                    .cornerRadius(10)

                if isLoading {
                    ProgressView("Signing in...")
                        .foregroundColor(.white)
                } else {
                    Button("Sign In") {
                        isLoading = true
                        authViewModel.signIn(email: email, password: password)
                    }
                    .padding()
                    .background(lightBrown)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }

                if let errorMessage = authViewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
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
