import SwiftUI
import FirebaseFirestore

struct HomeView: View {
    @ObservedObject var userViewModel: UserViewModel
    let userId: String
    @State private var isLoading = false
    @State private var showError = false
    @State private var showingAddLogView = false

    let lightBrown = Color(red: 222/255, green: 184/255, blue: 135/255)
    let darkBrown = Color(red: 139/255, green: 69/255, blue: 19/255)

    var body: some View {
        ZStack {
            darkBrown.ignoresSafeArea()
            
            NavigationView {
                VStack {
                    if isLoading {
                        ProgressView("Loading...")
                            .foregroundColor(.white)
                    } else if showError {
                        Text("Error loading data. Try again.")
                            .foregroundColor(.red)
                            .padding()
                        Button("Retry") {
                            fetchData()
                        }
                        .padding(10)
                        .background(lightBrown)
                        .foregroundColor(.black)
                        .cornerRadius(8)
                    } else if let user = userViewModel.user {
                        Text("Welcome, \(user.name)")
                            .font(.title)
                            .padding(10)
                            .background(lightBrown)
                            .foregroundColor(.black)
                            .cornerRadius(8)
                            
                        
                        if !userViewModel.userLogs.isEmpty {
                            List(userViewModel.userLogs) { log in
                                LogRow(log: log)
                                    .listRowBackground(lightBrown)
                            }
                            .scrollContentBackground(.hidden)
                            .background(darkBrown)
                        } else {
                            Text("No logs available.")
                                .foregroundColor(.gray)
                        }
                    } else {
                        Text("Fetching user data...")
                            .foregroundColor(.white)
                            .onAppear {
                                fetchData()
                            }
                    }
                }
                .background(lightBrown)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Sign Out") {
                            userViewModel.signOut()
                        }
                        .padding(6)
                        .background(darkBrown)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Add Log") {
                            showingAddLogView = true
                        }
                        .padding(6)
                        .background(darkBrown)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                }
                .sheet(isPresented: $showingAddLogView) {
                    AddLogView(userViewModel: userViewModel)
                }
            }
        }
    }

    func fetchData() {
        isLoading = true
        showError = false
        userViewModel.fetchUser(userId: userId) { error in
            isLoading = false
            if error != nil {
                showError = true
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let userViewModel = UserViewModel()
        userViewModel.user = User(id: "test", data: ["name": "Prueba", "email": "test@example.com"])
        userViewModel.userLogs = [
            Log(id: "log1", data: [
                "title": "Log de Prueba",
                "description": "Este es un log de prueba.",
                "location": GeoPoint(latitude: 37.7749, longitude: -122.4194)
            ])
        ]
        return HomeView(userViewModel: userViewModel, userId: "test")
    }
}
