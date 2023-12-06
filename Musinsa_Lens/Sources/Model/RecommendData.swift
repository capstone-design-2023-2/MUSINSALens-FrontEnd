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
    
    init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            brandName = (try? values.decode(String.self, forKey: .brandName)) ?? ""
            itemName = (try? values.decode(String.self, forKey: .itemName)) ?? ""
            price = (try? values.decode(String.self, forKey: .price)) ?? ""
            itemImage = (try? values.decode(String.self, forKey: .itemImage)) ?? ""
            itemUrl = (try? values.decode(String.self, forKey: .itemUrl)) ?? ""
        }
}



//    brand = "\Ud30c\Ube0c\Ub808\Uac00";
//    "image_url" = "https://image.msscdn.net/images/goods_img/20230823/3492981/3492981_16932113026128_500.jpg";
//    "info_url" = "https://www.musinsa.com/app/goods/3492981?loc=goods_rank";
//    name = "\Ubaa8\Uc790\Uc774\Ud06c \Uc634\Ube0c\Ub808 \Uccb4\Ud06c \Uc154\Uce20 (\Ubca0\Uc774\Uc9c0)";
//    price = "53,900\Uc6d0";
