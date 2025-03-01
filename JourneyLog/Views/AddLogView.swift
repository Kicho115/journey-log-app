//
//  AddLogView.swift
//  JourneyLog
//
//  Created by Oscar Angulo on 3/1/25.
//

import SwiftUI
import FirebaseFirestore
import MapKit

struct AddLogView: View {
    @ObservedObject var userViewModel: UserViewModel
    @State private var title = ""
    @State private var description = ""
    @State private var imageUrl: String?
    @State private var location: GeoPoint?
    @State private var selectedCoordinate: CLLocationCoordinate2D?
    @State private var isShowingMap = false

    var body: some View {
        VStack {
            TextField("Title", text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Description", text: $description)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Image", text: Binding(
                get: { imageUrl ?? "" },
                set: { imageUrl = $0.isEmpty ? nil : $0 }
            ))
            .textFieldStyle(RoundedBorderTextFieldStyle())

            if let coordinate = selectedCoordinate {
                Text("Location: Latitude \(coordinate.latitude), Altitude \(coordinate.longitude)")
            }

            Button("Choose location") {
                isShowingMap = true
            }

            Button("Add Log") {
                if let coordinate = selectedCoordinate {
                    location = GeoPoint(latitude: coordinate.latitude, longitude: coordinate.longitude)
                }
                userViewModel.addLog(title: title, description: description, imageUrl: imageUrl, location: location) { error in
                    if let error = error {
                        print("Error adding log: \(error.localizedDescription)")
                    }
                }
            }
        }
        .padding()
        .sheet(isPresented: $isShowingMap) {
            MapView(selectedCoordinate: $selectedCoordinate)
        }
    }
}
