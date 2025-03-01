//
//  MapView.swift
//  JourneyLog
//
//  Created by Oscar Angulo on 3/1/25.
//

import SwiftUI
import MapKit

struct MapView: View {
    @Binding var selectedCoordinate: CLLocationCoordinate2D?
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))

    var body: some View {
        Map(coordinateRegion: $region, annotationItems: annotations) { location in
            MapMarker(coordinate: location.coordinate)
        }
        .onTapGesture { location in
            selectedCoordinate = region.center
        }
    }

    // Map pins
    private var annotations: [IdentifiableCoordinate] {
        if let coordinate = selectedCoordinate {
            return [IdentifiableCoordinate(coordinate: coordinate)]
        } else {
            return []
        }
    }
}
