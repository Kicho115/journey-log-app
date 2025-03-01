import SwiftUI
import FirebaseFirestore
import MapKit

struct LogDetailView: View {
    let log: Log
    @State private var region: MKCoordinateRegion

    // Colores personalizados
    let lightBrown = Color(red: 222/255, green: 184/255, blue: 135/255) // Café claro
    let darkBrown = Color(red: 139/255, green: 69/255, blue: 19/255)   // Café oscuro

    init(log: Log) {
        self.log = log
        if let location = log.location {
            _region = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)))
        } else {
            _region = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))) // Default location
        }
    }

    var body: some View {
        ZStack {
            lightBrown.ignoresSafeArea() // Fondo café claro

            ScrollView {
                VStack(alignment: .leading) {
                    Text(log.title)
                        .font(.title)
                        .foregroundColor(darkBrown) // Texto del título café oscuro
                    Text(log.description)
                        .font(.body)
                        .padding(.vertical)
                    if let imageUrl = log.imageUrl, let url = URL(string: imageUrl) {
                        AsyncImage(url: url) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    if let location = log.location {
                        Map(coordinateRegion: $region, annotationItems: [IdentifiableCoordinate(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))]) { location in
                            MapMarker(coordinate: location.coordinate)
                        }
                        .frame(height: 200)
                    }
                    Text("Creado el: \(log.createdAt, style: .date)")
                        .font(.caption)
                    
                    if let location = log.location {
                        Button("Abrir en Mapas") {
                            openMaps(location: location)
                        }
                        .padding()
                        .background(darkBrown)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                }
                .padding()
            }
            .navigationTitle(log.title)
        }
    }

    func openMaps(location: GeoPoint) {
        let coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
        mapItem.name = log.title
        mapItem.openInMaps()
    }
}
