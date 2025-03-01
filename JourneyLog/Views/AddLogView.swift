import SwiftUI
import FirebaseFirestore
import MapKit
import UIKit

struct AddLogView: View {
    @ObservedObject var userViewModel: UserViewModel
    @Environment(\.presentationMode) private var presentationMode  
    @State private var title = ""
    @State private var description = ""
    @State private var location: GeoPoint?
    @State private var selectedCoordinate: CLLocationCoordinate2D?
    @State private var isShowingMap = false
    @State private var isShowingImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var imagePath: String?

    let lightBrown = Color(red: 222/255, green: 184/255, blue: 135/255)
    let darkBrown = Color(red: 139/255, green: 69/255, blue: 19/255)

    var body: some View {
        ZStack {
            darkBrown.ignoresSafeArea()

            VStack {
                TextField("Title", text: $title)
                    .padding()
                    .background(lightBrown)
                    .cornerRadius(8)
                TextField("Description", text: $description)
                    .padding()
                    .background(lightBrown)
                    .cornerRadius(8)

                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 200)
                }

                Button("Take Photo") {
                    isShowingImagePicker = true
                }
                .padding()
                .background(lightBrown)
                .cornerRadius(8)

                if let coordinate = selectedCoordinate {
                    Text("Location: Latitude \(coordinate.latitude), Longitude \(coordinate.longitude)")
                        .foregroundColor(.white)
                }

                Button("Choose location") {
                    isShowingMap = true
                }
                .padding()
                .background(lightBrown)
                .cornerRadius(8)

                Button("Add Log") {
                    if let coordinate = selectedCoordinate {
                        location = GeoPoint(latitude: coordinate.latitude, longitude: coordinate.longitude)
                    }
                    addLogToFirestore()
                }
                .padding()
                .background(lightBrown)
                .cornerRadius(8)
            }
            .padding()
        }
        .sheet(isPresented: $isShowingMap) {
            MapView(selectedCoordinate: $selectedCoordinate)
        }
        .sheet(isPresented: $isShowingImagePicker) {
            ImagePicker(image: $selectedImage, imagePath: $imagePath)
        }
    }

    func addLogToFirestore() {
        userViewModel.addLog(title: title, description: description, imageUrl: imagePath, location: location) { error in
            if let error = error {
                print("Error adding log: \(error.localizedDescription)")
            } else {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}
