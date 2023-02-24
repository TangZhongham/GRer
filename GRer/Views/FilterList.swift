//
//  FilterList.swift
//  GRer
//
//  Created by 唐某某 on 2023/2/24.
//

import SwiftUI

struct FilterList: View {
    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        // 整合 GridView
        List(filters, id: \.id) { filter in
                    GridView(filter: filter)
                }
    }
}

struct FilterList_Previews: PreviewProvider {
    static var previews: some View {
        FilterList()
    }
}
