//
//  GRerApp.swift
//  GRer
//
//  Created by 唐某某 on 2023/2/23.
//

import SwiftUI

@main
struct GRerApp: App {
    let persistenceController = PersistenceController.shared
    
    @StateObject private var modelData = ModelData()

    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            FilterList()
                .environmentObject(modelData)
        }
    }
}
