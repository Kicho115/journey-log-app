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

    // Colores personalizados
    let lightBrown = Color(red: 222/255, green: 184/255, blue: 135/255) // Café claro
    let darkBrown = Color(red: 139/255, green: 69/255, blue: 19/255)   // Café oscuro

    var body: some View {
        ZStack { // ZStack para el fondo café oscuro
            darkBrown.ignoresSafeArea()

            VStack {
                TextField("Title", text: $title)
                    .padding()
                    .background(lightBrown) // Fondo café claro para el TextField
                    .cornerRadius(8)
                TextField("Description", text: $description)
                    .padding()
                    .background(lightBrown) // Fondo café claro para el TextField
                    .cornerRadius(8)
                TextField("Image", text: Binding(
                    get: { imageUrl ?? "" },
                    set: { imageUrl = $0.isEmpty ? nil : $0 }
                ))
                .padding()
                .background(lightBrown) // Fondo café claro para el TextField
                .cornerRadius(8)

                if let coordinate = selectedCoordinate {
                    Text("Location: Latitude \(coordinate.latitude), Longitude \(coordinate.longitude)")
                        .foregroundColor(.white)
                }

                Button("Choose location") {
                    isShowingMap = true
                }
                .padding()
                .background(lightBrown) // Fondo café claro para el botón
                .cornerRadius(8)

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
                .padding()
                .background(lightBrown) // Fondo café claro para el botón
                .cornerRadius(8)
            }
            .padding()
        }
        .sheet(isPresented: $isShowingMap) {
            MapView(selectedCoordinate: $selectedCoordinate)
        }
    }
}
