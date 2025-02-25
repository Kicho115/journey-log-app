//
//  JourneyLogApp.swift
//  JourneyLog
//
//  Created by Oscar Angulo on 2/21/25.
//

import SwiftUI
import Firebase

@main
struct JourneyLogApp: App {
    
    init() {
        FirebaseApp.configure() // Initialize firebase when the app starts
    }
    
    var body: some Scene {
        WindowGroup {
            PermissionsView()
        }
    }
}
