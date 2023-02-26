//
//  PermissionsSection.swift
//  GRer
//
//  Created by 唐某某 on 2023/2/26.
//

import Foundation
import AVFoundation
import MediaCore
import Photos
import SwiftUI

struct PermissionsSection: View {
    @State private var isLimitedLibraryPickerPresented = false
    @State private var cameraPermission: AVAuthorizationStatus = .notDetermined
    @State private var mediaPermission: PHAuthorizationStatus = .notDetermined

    var requestedPermission: (Result<Void, PermissionError>) -> Void

    var body: some View {
        Section(header: Text("Permissions")) {
            Button(action: {
                Media.requestCameraPermission { _ in
                    cameraPermission = Media.currentCameraPermission
                }
            }) {
                HStack {
                    Text("Trigger camera permission request")
                    Toggle("", isOn: .constant(cameraPermission == .authorized))
                        .disabled(true)
                }
            }

            Button(action: {
                if Media.currentPermission == .limited {
                    isLimitedLibraryPickerPresented = true
                } else {
                    requestPermission()
                }
            }) {
                HStack {
                    Text("Trigger photo library permission request")
                    Toggle("", isOn: .constant(mediaPermission == .authorized))
                        .disabled(true)
                }
            }
            .background(PHPicker(isPresented: $isLimitedLibraryPickerPresented))
        }
        .onAppear {
            cameraPermission = Media.currentCameraPermission
            mediaPermission = Media.currentPermission
        }
    }
}

private extension PermissionsSection {
    func requestPermission() {
        Media.requestPermission { result in
            mediaPermission = Media.currentPermission
            requestedPermission(result)
        }
    }
}
