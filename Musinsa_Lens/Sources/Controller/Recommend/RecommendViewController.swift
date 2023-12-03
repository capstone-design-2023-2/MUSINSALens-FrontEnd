//
//  RecommendViewController.swift
//  Musinsa_Lens
//
//  Created by 박예린 on 2023/11/26.
//

import UIKit
import Alamofire

class RecommendViewController: UIViewController {
    
    @IBOutlet var brandlabel: UILabel!
    @IBOutlet var basicButton: UIButton!
    @IBOutlet var colorButton: UIButton!
    @IBOutlet var fitButton: UIButton!
    @IBOutlet var textureButton: UIButton!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Action
    @IBAction func SortButtonTapped(_ sender: UIButton) {
        
        RecommendDataService.shared.getRecommendData{ (response) in
            
            //NetworkResult형 enum값을 이용해서 분기처리
            switch(response) {
            case .success(let recommendData):
                if let data = recommendData as? RecommendData {
                    self.brandlabel.text = data.name
                    
                }
            case .requestErr(let message) :
                print("requestErr", message)
            case .pathErr :
                print("pathErr?")
            case .serverErr :
                print("severErr?")
            case .networkFail :
                print("networkFail")
            }
        }
    }
}
