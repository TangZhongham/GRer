//
//  FilterDetail.swift
//  GRer
//
//  Created by 唐某某 on 2023/2/25.
//

import SwiftUI

struct FilterDetail: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var filter: Filter
    
    var filterIndex: Int {
        modelData.filters.firstIndex(where: { $0.id == filter.id })!
    }
    
    var body: some View {
        ScrollView {
        
            
            VStack(alignment: .leading) {
                HStack {
                    Text(filter.filter_name)
                        .font(.title)
                    FavoriteButton(isSet: $modelData.filters[filterIndex].is_star)
                }
                .padding(.leading)
            
                HStack {
                    Text(filter.camera)
                    //                Text(filter.is_star)
                    Spacer()
//                    if filter.is_star {
//                        //                        Text("🌟")
//                        Image(systemName: "star.fill")
//                            .foregroundColor(.yellow)
//                    }
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.leading)
            }
            
            Divider()
            
            Group {
                Text("About \(filter.filter_name)")
                    .font(.title2)
                Text(filter.detail.effect)
                Text(filter.detail.white_balance)
                Text(String(filter.detail.hue))
                Text(String(filter.detail.iso))
                Text(String(filter.detail.saturation))
                
            }
            
            Divider()
            
            Text("Photos View")
            //                .padding(.top)
                .foregroundColor(.pink)
                .ignoresSafeArea(edges: .top)
                .frame(height: 200)
            
            
        }
        .navigationTitle(filter.filter_name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FilterDetail_Previews: PreviewProvider {
    static var previews: some View {
        FilterDetail(filter: ModelData().filters[0])
            .environmentObject(ModelData())
    }
}
