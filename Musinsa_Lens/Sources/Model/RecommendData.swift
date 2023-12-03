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
    let id: Int
    let name: String
    let type: String
    let available: Bool
//    let titleIdx: Int
//    let title: String
//    let image: String
//    let review, customer: Int
//    let place: String
//    let bookmark: Bool
//    let v: Int

    enum CodingKeys: String, CodingKey {
        case id, name, type, available
//        case titleIdx = "title_idx"
//        case title, image, review, customer, place, bookmark
//        case v = "__v"
    }
}
