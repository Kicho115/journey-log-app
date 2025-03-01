//
//  IdentifiableCoordinate.swift
//  JourneyLog
//
//  Created by Oscar Angulo on 3/1/25.
//

import MapKit

// Indentifiable CLLocationCoordinate2D to mark the points in the map
struct IdentifiableCoordinate: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}
