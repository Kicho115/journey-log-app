//
//  Log.swift
//  JourneyLog
//
//  Created by Oscar Angulo on 2/28/25.
//

import FirebaseFirestore

struct Log: Identifiable {
    let id: String
    let title: String
    let description: String
    let imageUrl: String?
    let location: GeoPoint?
    let createdAt: Date

    init(id: String, data: [String: Any]) {
        self.id = id
        self.title = data["title"] as? String ?? "Sin título"
        self.description = data["description"] as? String ?? "Sin descripción"
        self.imageUrl = data["imageUrl"] as? String
        self.location = data["location"] as? GeoPoint
        self.createdAt = (data["createdAt"] as? Timestamp)?.dateValue() ?? Date()
    }
}
