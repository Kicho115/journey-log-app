//
//  HomeView.swift
//  JourneyLog
//
//  Created by Oscar Angulo on 3/1/25.
//

import SwiftUI
import FirebaseFirestore
import MapKit

struct HomeView: View {
    @ObservedObject var userViewModel: UserViewModel
    let userId: String
    @State private var isLoading = false
    @State private var showError = false
    @State private var showingAddLogView = false

    var body: some View {
        NavigationView {
            VStack {
                if isLoading {
                    ProgressView("Loading...")
                } else if showError {
                    Text("Error loading data. Try again.")
                        .foregroundColor(.red)
                        .padding()
                    Button("Retry") {
                        fetchData()
                    }
                } else if let user = userViewModel.user {
                    Text("Welcome, \(user.name)")
                        .font(.title)

                    if !userViewModel.userLogs.isEmpty {
                        List(userViewModel.userLogs) { log in
                            LogRow(log: log)
                        }
                    } else {
                        Text("No logs avaiable.")
                            .foregroundColor(.gray)
                    }
                } else {
                    Text("Fetching user data...")
                        .onAppear {
                            fetchData()
                        }
                }
            }
            .toolbar {
                Button("Sign Out"){
                    userViewModel.signOut()
                }
                Button("Add Log") {
                    showingAddLogView = true
                }
            }
            .sheet(isPresented: $showingAddLogView) {
                AddLogView(userViewModel: userViewModel)
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

struct LogRow: View {
    let log: Log

    var body: some View {
        VStack(alignment: .leading) {
            Text(log.title)
                .font(.headline)
            Text(log.description)
                .font(.subheadline)
            if let location = log.location {
                HStack {
                    Text("Lat: \(location.latitude), Lon: \(location.longitude)")
                        .font(.caption)
                    Button(action: {
                        openMaps(location: location)
                    }, label: {
                        Image(systemName: "map")
                    })
                }

            }
        }
    }

    func openMaps(location: GeoPoint) {
        let coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
        mapItem.name = log.title
        mapItem.openInMaps()
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
