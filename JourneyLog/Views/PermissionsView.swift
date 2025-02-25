//
//  PermissionsView.swift
//  JourneyLog
//
//  Created by Oscar Angulo on 2/24/25.
//

import SwiftUI

struct PermissionsView: View {
    @StateObject private var permissionViewModel = PermissionsViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Text("Permissions app")
                    .padding()
                Text("Click on each button to accept all permissions")
                    .multilineTextAlignment(.center)
                VStack(spacing: 20) {
                    Button(action: {
                        permissionViewModel.requestCameraAccess()
                    }){
                        Text("Allow access to the camera")
                    }
                    .disabled(permissionViewModel.cameraGranted)
                    Button(action: {
                        permissionViewModel.requestLocationAccess()
                    }){
                        Text("Allow access to your location")
                    }
                    .disabled(permissionViewModel.locationGranted)
                    Button(action: {
                        permissionViewModel.requestPhotoLibraryAccess()
                    }){
                        Text("Allow access to the Photo Library (Read/Write)")
                    }
                    .disabled(permissionViewModel.photoLibraryGranted)
                    Button(action: {
                        permissionViewModel.requestPhotoLibraryAddAccess()
                    }){
                        Text("Allow access to add Photos to Library")
                    }
                    .disabled(permissionViewModel.photoLibraryGranted)
                }
                Spacer()
                NavigationLink("Next", value: "OptionView")
                    .disabled(!permissionViewModel.areAllPermissionsGranted)
                    .tint(.orange)
            }
            .navigationDestination(for: String.self) { value in
                if value == "OptionView" {
                    MainMenuView()
                }
            }
        }
    }
}

#Preview {
    PermissionsView()
}
