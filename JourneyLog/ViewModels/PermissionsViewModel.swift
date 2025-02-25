//
//  PermissionsViewModel.swift
//  JourneyLog
//
//  Created by Oscar Angulo on 2/24/25.
//

import Foundation
import Photos
import CoreLocation
import AVFoundation

class PermissionsViewModel: ObservableObject {
    @Published var cameraGranted = false
    @Published var photoLibraryGranted = false
    @Published var locationGranted = false
    
    var areAllPermissionsGranted: Bool {
        return cameraGranted && photoLibraryGranted && locationGranted
    }
    
    func requestCameraAccess() {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            DispatchQueue.main.async {
                self.cameraGranted = granted
            }
        }
    }
    
    func requestPhotoLibraryAccess() {
        let currentStatus = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        
        if currentStatus == .notDetermined {
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                DispatchQueue.main.async {
                    self.photoLibraryGranted = (status == .authorized || status == .limited)
                }
            }
        } else {
            self.photoLibraryGranted = (currentStatus == .authorized || currentStatus == .limited)
        }
    }
    
    func requestLocationAccess() {
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        DispatchQueue.main.async {
            let status = locationManager.authorizationStatus
            self.locationGranted = (status == .authorizedWhenInUse || status == .authorizedAlways)
        }
    }

    func requestPhotoLibraryAddAccess() {
        let currentStatus = PHPhotoLibrary.authorizationStatus(for: .addOnly)
        
        if currentStatus == .notDetermined {
            PHPhotoLibrary.requestAuthorization(for: .addOnly) { status in
                DispatchQueue.main.async {
                    self.photoLibraryGranted = (status == .authorized)
                }
            }
        } else {
            self.photoLibraryGranted = (currentStatus == .authorized)
        }
    }
}
