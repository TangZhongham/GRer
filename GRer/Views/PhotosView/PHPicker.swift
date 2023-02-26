//
//  PHPicker.swift
//  GRer
//
//  Created by 唐某某 on 2023/2/26.
//

import PhotosUI
import SwiftUI

struct PHPicker: UIViewControllerRepresentable {
    @Binding var isPresented: Bool

    func makeUIViewController(context: Context) -> UIViewController {
        UIViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if isPresented {
            PHPhotoLibrary.shared().presentLimitedLibraryPicker(from: uiViewController)
            DispatchQueue.main.async {
                isPresented = false
            }
        }
    }
}

#if DEBUG
struct PHPicker_Previews: PreviewProvider {
    static var previews: some View {
        PHPicker(isPresented: .constant(false))
    }
}
#endif
