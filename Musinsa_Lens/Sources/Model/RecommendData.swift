//
//  RecommendData.swift
//  Musinsa_Lens
//
//  Created by 박예린 on 2023/12/01.
//

import Foundation

// MARK: - RecommendDataModel
struct RecommendDataModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: [RecommendData]?
}

// MARK: - Recommend Data
struct RecommendData: Codable {
    let brand: String
    let itemName: String
    let price: String
    let itemImage: Bool


    enum CodingKeys: String, CodingKey {
        case brand,itemName,price,itemImage
    }
}
