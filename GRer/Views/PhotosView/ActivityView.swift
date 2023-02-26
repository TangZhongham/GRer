//
//  ActivityView.swift
//  GRer
//
//  Created by 唐某某 on 2023/2/26.
//

import Foundation
import SwiftUI
import UIKit

struct ActivityView<T: AnyObject>: UIViewControllerRepresentable {
    let activityItems: [T]
    let applicationActivities: [UIActivity]

    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityView<T>>) -> UIActivityViewController {
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return activityViewController
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityView<T>>) {

    }
}
