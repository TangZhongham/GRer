//
//  FilterList.swift
//  GRer
//
//  Created by 唐某某 on 2023/2/24.
//

import SwiftUI

struct FilterList: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showFavoritesOnly = false
    
    var StaredFilters: [Filter] {
        modelData.filters.filter { filter in
            (!showFavoritesOnly || filter.is_star)
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Favorites only")
                }
                ScrollView {
                    ForEach(StaredFilters) { filter in
                        NavigationLink {
                            FilterDetail(filter: filter)
                        } label: {
                            GridView(filter: filter)
                        }
                        // 文字悬浮在图片上方
//                        .overlay(TextOverlay(filter: filter))
                    }
                    .navigationTitle("GR Filters")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            EditButton()
                        }
                        ToolbarItem {
                            Button(action: addItem) {
                                Label("Add Item", systemImage: "plus")
                            }
                        }
                    }
                    
                }
            }
        }
    }
    
    private func addItem() {
        print("add items")
    }

    private func deleteItems(offsets: IndexSet) {
        print("delete items")
    }
}

struct TextOverlay: View {
    var filter: Filter

    var gradient: LinearGradient {
        .linearGradient(
            Gradient(colors: [.black.opacity(0.6), .black.opacity(0)]),
            startPoint: .bottom,
            endPoint: .center)
    }

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            gradient
            VStack(alignment: .leading) {
                Text(filter.filter_name)
                    .font(.title)
                    .bold()
                Text(filter.camera)
            }
            .padding()
        }
        .foregroundColor(.white)
    }
}


struct FilterList_Previews: PreviewProvider {
    static var previews: some View {
        FilterList()
            .environmentObject(ModelData())
    }
}
