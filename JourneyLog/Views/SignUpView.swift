import SwiftUI

struct SignUpView: View {
    @StateObject var authViewModel = UserViewModel()
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @State private var isLoggedIn = false
    
    // Colores personalizados
    let lightBrown = Color(red: 222/255, green: 184/255, blue: 135/255)
    let darkBrown = Color(red: 139/255, green: 69/255, blue: 19/255)
    let mediumBrown = Color(red: 160/255, green: 82/255, blue: 45/255)
    let lightMediumBrown = Color(red: 205/255, green: 133/255, blue: 63/255)
    let darkMediumBrown = Color(red: 101/255, green: 67/255, blue: 33/255) 

    var body: some View {
        ZStack {
            darkBrown.ignoresSafeArea()

            
            GeometryReader { geometry in
                Circle()
                    .fill(lightMediumBrown.opacity(0.6))
                    .frame(width: geometry.size.width * 0.6)
                    .position(x: geometry.size.width * 0.1, y: geometry.size.height * 0.2)

                Circle()
                    .fill(lightMediumBrown.opacity(0.7))
                    .frame(width: geometry.size.width * 0.7)
                    .position(x: geometry.size.width * 0.9, y: geometry.size.height * 0.6)

                Circle()
                    .fill(lightBrown.opacity(0.4))
                    .frame(width: geometry.size.width * 0.9)
                    .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.5)
                
                Circle()
                    .fill(darkMediumBrown.opacity(0.9))
                    .frame(width: geometry.size.width * 0.7)
                    .position(x: geometry.size.width * 0.2, y: geometry.size.height * 0.9)
                
                Circle()
                    .fill(lightMediumBrown.opacity(0.3))
                    .frame(width: geometry.size.width * 0.45)
                    .position(x: geometry.size.width * 0.7, y: geometry.size.height * 0.1)
            }

            VStack {
                TextField("Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()
                    .background(lightBrown)
                    .cornerRadius(10)
                
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
                
                Button("Sign Up") {
                    authViewModel.signUp(email: email, password: password, name: name)
                }
                .padding()
                .background(lightBrown)
                .foregroundColor(.black)
                .cornerRadius(10)
                
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .fullScreenCover(isPresented: $authViewModel.isLoggedIn) {
            if let user = authViewModel.user {
                HomeView(userViewModel: authViewModel, userId: user.id)
            }
        }
    }
}

#Preview {
    SignUpView()
}
