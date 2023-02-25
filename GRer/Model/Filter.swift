//
//  Filter.swift
//  GRer
//
//  Created by 唐某某 on 2023/2/24.
//

import Foundation

struct Filter: Hashable, Codable, Identifiable {
    var id: Int
    var camera: String
    var filter_name: String
    var is_star: Bool
    var detail: Detail

    var personal_info: String
    
    struct Detail: Hashable, Codable {
        var effect: String
        var saturation: Int
        var hue: Int
        var iso: Int
        var white_balance: String
    }
    
}
