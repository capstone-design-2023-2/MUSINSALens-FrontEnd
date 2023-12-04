//
//  CollectionViewCell.swift
//  Musinsa_Lens
//
//  Created by 박예린 on 2023/11/26.
//

import Foundation
import UIKit
import Kingfisher

/// 홈 - 추천 아이템 정보 셀
class RecommendCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var itemView: UIView!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var itemImageView: UIImageView!
    
    // MARK: - Properties
    static let identifier = "RecommendItemCVC"
    
    // MARK: - Life Cycle
    func cellConfigure() {
        
        self.brandLabel.textAlignment = .left
        self.itemLabel.textAlignment = .left
        self.priceLabel.textAlignment = .left
    }
    
    // MARK: - Set Data
    func setData(brandName: String,
                 itemName: String,
                 price: String,
                 itemImage: String) {
        self.brandLabel.text = brandName
        self.itemLabel.text = itemName
        self.priceLabel.text = price
        if let imageURL = URL(string: itemImage) {
            self.itemImageView.kf.setImage(with: imageURL)
        }
    }
}
