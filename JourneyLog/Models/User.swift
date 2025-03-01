//
//  User.swift
//  JourneyLog
//
//  Created by Oscar Angulo on 2/22/25.
//

struct User: Identifiable {
    let id: String
    let email: String
    let name: String
    let logs: [Log]?

    init(id: String, data: [String: Any]) {
        self.id = id
        self.email = (data["email"] as? String) ?? ""
        self.name = (data["name"] as? String) ?? ""
        self.logs = nil 
    }
}
