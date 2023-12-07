//
//  RecommendData.swift
//  Musinsa_Lens
//
//  Created by 박예린 on 2023/12/01.
//

import Foundation

// MARK: - RecommendDataModel
struct RecommendDataModel: Codable {
//    let status: Int
//    let success: Bool
//    let message: String
    let data: [RecommendData]?
}

// MARK: - Recommend Data
struct RecommendData: Codable {
    let brandName: String
    let itemName: String
    let price: String
    let itemImage: String
    let itemUrl : String


    enum CodingKeys: String, CodingKey {
        case brandName = "brand"
        case itemName = "name"
        case price
        case itemImage = "image_url"
        case itemUrl = "info_url"
    }
}
