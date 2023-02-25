//
//  GridView.swift
//  GRer
//
//  Created by 唐某某 on 2023/2/24.
//

import SwiftUI

struct GridView: View {
    var filter: Filter
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(filter.filter_name)
                .font(.title)
            HStack {
                Text("100 张")
                    .font(.subheadline)
                Spacer()
                Text(filter.camera)
                    .font(.subheadline)
                if filter.is_star {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                } else {
                    Image(systemName: "star.fill")
                        .foregroundColor(.white)
                }
            }
        }
        .padding()
    }
}

struct GridView_Previews: PreviewProvider {
    static var filters = ModelData().filters
    
    static var previews: some View {
        Group {
            GridView(filter: filters[0])
            GridView(filter: filters[1])
            GridView(filter: filters[2])
        }
        .previewLayout(.fixed(width: 400, height: 300))
    }
}
