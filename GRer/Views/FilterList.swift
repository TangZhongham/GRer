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
                    }
                    .navigationTitle("GR Filters")
                }
            }
        }
    }
}

struct FilterList_Previews: PreviewProvider {
    static var previews: some View {
        FilterList()
            .environmentObject(ModelData())
    }
}
