import SwiftUI
import FirebaseFirestore
import MapKit

struct LogRow: View {
    let log: Log

    let lightBrown = Color(red: 222/255, green: 184/255, blue: 135/255) // Café claro
    let darkBrown = Color(red: 139/255, green: 69/255, blue: 19/255)   // Café oscuro

    var body: some View {
        ZStack {
            
            NavigationLink(destination: LogDetailView(log: log)) {
                VStack(alignment: .leading) {
                    Text(log.title)
                        .font(.headline)
                        .foregroundColor(.black)
                    Text(log.description)
                        .font(.subheadline)
                        .foregroundColor(.black)
                    if let location = log.location {
                        HStack {
                            Text("Lat: \(location.latitude), Lon: \(location.longitude)")
                                .font(.caption)
                                .foregroundColor(.black)
                            Button(action: {
                                openMaps(location: location)
                            }, label: {
                                Image(systemName: "map")
                                    .foregroundColor(.black)
                            })
                        }
                    }
                }
                .padding()
                .cornerRadius(8)
            }
            .padding(.horizontal)
            .padding(.vertical, 4)
        }
    }

    func openMaps(location: GeoPoint) {
        let coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
        mapItem.name = log.title
        mapItem.openInMaps()
    }
}
