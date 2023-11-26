//
//  CollectionViewCell.swift
//  Musinsa_Lens
//
//  Created by 박예린 on 2023/11/26.
//

import Foundation
import UIKit

/// 홈 - 추천 아이템 정보 셀
class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var itemView: UIView!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet var priceLabel:UILabel!
    @IBOutlet var itemImageView:UIImageView!
    
    
    func cellConfigure() {
        
        self.brandLabel.textAlignment = .left
        
        self.itemLabel.textAlignment = .left
        
        self.priceLabel.textAlignment = .left
    }
}
