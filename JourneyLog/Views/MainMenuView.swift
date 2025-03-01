import SwiftUI

struct MainMenuView: View {
    let lightBrown = Color(red: 222/255, green: 184/255, blue: 135/255)
    let darkBrown = Color(red: 139/255, green: 69/255, blue: 19/255)
    let mediumBrown = Color(red: 160/255, green: 82/255, blue: 45/255)
    let lightMediumBrown = Color(red: 205/255, green: 133/255, blue: 63/255)

    var body: some View {
        ZStack {
            lightBrown.ignoresSafeArea()

            // Figuras circulares de fondo
            GeometryReader { geometry in
                Circle()
                    .fill(mediumBrown.opacity(0.3))
                    .frame(width: geometry.size.width * 0.4)
                    .position(x: geometry.size.width * 0.1, y: geometry.size.height * 0.2)

                Circle()
                    .fill(lightMediumBrown.opacity(0.6))
                    .frame(width: geometry.size.width * 0.3)
                    .position(x: geometry.size.width * 0.8, y: geometry.size.height * 0.7)

                Circle()
                    .fill(darkBrown.opacity(0.3))
                    .frame(width: geometry.size.width * 0.5)
                    .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.5)
                
                Circle()
                    .fill(darkBrown.opacity(0.2))
                    .frame(width: geometry.size.width * 0.5)
                    .position(x: geometry.size.width * 0.1, y: geometry.size.height * 0.2)
                
                Circle()
                    .fill(darkBrown.opacity(0.5))
                    .frame(width: geometry.size.width * 0.7)
                    .position(x: geometry.size.width * 0.3, y: geometry.size.height * 0.9)
                
                Circle()
                    .fill(lightMediumBrown.opacity(0.3))
                    .frame(width: geometry.size.width * 0.6)
                    .position(x: geometry.size.width * 0.9, y: geometry.size.height * 0.1)
                
                Circle()
                    .fill(mediumBrown.opacity(0.3))
                    .frame(width: geometry.size.width * 0.4)
                    .position(x: geometry.size.width * 0.8, y: geometry.size.height * 0.7)
            }

            VStack {
                Text("Journey Log")
                    .font(.largeTitle)
                    .padding()
                    .background(darkBrown)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.bottom, 50)

                HStack {
                    NavigationLink(destination: SignInView()) {
                        Text("Log In")
                            .padding()
                            .background(darkBrown)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    NavigationLink(destination: SignUpView()) {
                        Text("Sign Up")
                            .padding()
                            .background(darkBrown)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle()) 
    }
}

#Preview {
    MainMenuView()
}
