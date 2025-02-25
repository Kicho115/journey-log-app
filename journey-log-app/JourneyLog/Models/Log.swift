//
//  Log.swift
//  JourneyLog
//
//  Created by CETYS Universidad  on 24/02/25.
//

import MapKit

struct Log: Identifiable {
    let id = UUID()
    var title : String
    var description : String
    var Image : String
    var location : CLLocationCoordinate2D
    var date : Date
    
}
