//
//  PermissionsViewModel.swift
//  JourneyLog
//
//  Created by Oscar Angulo on 2/24/25.
//

import SwiftUI

struct PermissionsView: View {
    @StateObject private var permissionViewModel = PermissionsViewModel()

    let lightBrown = Color(red: 222/255, green: 184/255, blue: 135/255)
    let darkBrown = Color(red: 139/255, green: 69/255, blue: 19/255)

    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Spacer()
                Text("Click on each button to accept all permissions")
                    .multilineTextAlignment(.center)
                    .padding(6)
                    .background(darkBrown)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .fontWeight(.heavy)
                    .font(.title2)
                VStack( spacing: 20) {
                    Spacer()
                    Button(action: {
                        permissionViewModel.requestCameraAccess()
                    }){
                        Text("Allow access to the camera")
                            .foregroundColor(darkBrown)
                            .opacity(permissionViewModel.cameraGranted ? 0.5 : 1.0)

                    }
                    .disabled(permissionViewModel.cameraGranted)
                    Button(action: {
                        permissionViewModel.requestLocationAccess()
                    }){
                        Text("Allow access to your location")
                            .foregroundColor(darkBrown)
                            .opacity(permissionViewModel.locationGranted ? 0.5 : 1.0)
                    }
                    .disabled(permissionViewModel.locationGranted)
                    Button(action: {
                        permissionViewModel.requestPhotoLibraryAccess()
                    }){
                        Text("Allow access to the Photo Library (Read/Write)")
                            .foregroundColor(darkBrown)
                            .opacity(permissionViewModel.photoLibraryGranted ? 0.5 : 1.0)
                    }
                    .disabled(permissionViewModel.photoLibraryGranted)
                    Button(action: {
                        permissionViewModel.requestPhotoLibraryAddAccess()
                    }){
                        Text("Allow access to add Photos to Library")
                            .foregroundColor(darkBrown)
                            .opacity(permissionViewModel.photoLibraryGranted ? 0.5 : 1.0)
                    }
                    .disabled(permissionViewModel.photoLibraryGranted)
                    Spacer()

                }
                .frame(maxWidth: .infinity, alignment: .center)
                Spacer()
                NavigationLink("Next", value: "OptionView")
                    .disabled(!permissionViewModel.areAllPermissionsGranted)
                    .padding(6)
                    .background(darkBrown)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .tint(.orange)
            }
            .navigationDestination(for: String.self) { value in
                if value == "OptionView" {
                    MainMenuView()
                        .navigationBarBackButtonHidden(true)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(lightBrown)
        }
    }
}

#Preview {
    PermissionsView()
}
