//
//  RecommendViewController.swift
//  Musinsa_Lens
//
//  Created by 박예린 on 2023/11/26.
//

import UIKit
import Alamofire

class RecommendViewController: UIViewController {
    
    fileprivate let systemImageNameArray = [
        "moon", "zzz", "sparkles", "cloud", "tornado", "smoke.fill", "tv.fill", "gamecontroller", "headphones", "flame", "bolt.fill", "hare", "tortoise", "moon", "zzz", "sparkles", "cloud", "tornado", "smoke.fill", "tv.fill", "gamecontroller", "headphones", "flame", "bolt.fill", "hare", "tortoise", "ant", "hare", "car", "airplane", "heart", "bandage", "waveform.path.ecg", "staroflife", "bed.double.fill", "signature", "bag", "cart", "creditcard", "clock", "alarm", "stopwatch.fill", "timer"
    ]
    
    
    // MARK: - Property
    
    @IBOutlet weak var RecommendCollectionView: UICollectionView!
    
    @IBOutlet var basicButton: UIButton!
    @IBOutlet var colorButton: UIButton!
    @IBOutlet var fitButton: UIButton!
    @IBOutlet var textureButton: UIButton!
    
    //오류방지용
    @IBOutlet var brandLabel: UILabel!

    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 콜렉션 뷰에 대한 설정
        RecommendCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        RecommendCollectionView.dataSource = self
        RecommendCollectionView.delegate = self
        
        // 닙파일을 가져온다
        let myCustomCollectionViewCellNib = UINib(nibName: String(describing: RecommendCollectionViewCell.self), bundle: nil)

        
        // 가져온 닙파일로 콜렉션뷰에 쎌로 등록한다
        self.RecommendCollectionView.register(myCustomCollectionViewCellNib, forCellWithReuseIdentifier: String(describing: RecommendCollectionViewCell.self))


    }
    // MARK: - 데이터 가져오기
    func setRecommendServiceList() {
    
        RecommendDataService.shared.getRecommendData { (response) in
            switch(response) {
                
            case .success(let recommendDataList):
                
                
                if let RecommendedDataList = recommendDataList as? [RecommendData] {
                    for recommendData in RecommendedDataList {
                        
                        // 원하는 대로 UI 업데이트 또는 기타 처리 수행
                        print(recommendData.brand, recommendData.itemName, recommendData.price, recommendData.itemImage)
                        
                    }
                } else {
                    print("Recommend 데이터가 수신되지 않았습니다.")
                }
                
            case .requestErr(let message):
                // 요청 에러 처리
                print("요청 에러", message)
            case .pathErr:
                // 경로 에러 처리
                print("경로 에러")
            case .serverErr:
                // 서버 에러 처리
                print("서버 에러")
            case .networkFail:
                // 네트워크 연결 실패 처리
                print("네트워크 연결 실패")
            }
        }
    }

    
    // MARK: - Action
    @IBAction func SortButtonTapped(_ sender: UIButton) {
        //case문 써가지고 4가지 상황으로 나누기
        RecommendDataService.shared.getRecommendData{ (response) in
            
            //NetworkResult형 enum값을 이용해서 분기처리
            switch(response) {
            case .success(let recommendData):
                if let data = recommendData as? RecommendData {
                    self.brandLabel.text = data.brand
                    
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

// MARK: - UICollectionViewDataSource

extension RecommendViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.systemImageNameArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: RecommendCollectionViewCell.self), for: indexPath) as! RecommendCollectionViewCell
        
        /// 이미지뷰 설정
        cell.itemImageView.image = UIImage(systemName: self.systemImageNameArray[indexPath.item])
            
            // 이미지 크기
            let cell_width = (UIScreen.main.bounds.width-15)/2
            cell.itemImageView.frame = CGRect(x: 0, y: 0, width: cell_width , height: cell_width)
        
        /// 텍스트뷰 설정
        cell.brandLabel.text = self.systemImageNameArray[indexPath.item]
        
        cell.contentView.backgroundColor = UIColor.blue
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension RecommendViewController: UICollectionViewDelegate { }


// MARK: - UICollectionViewDelegateFlowLayout
extension RecommendViewController: UICollectionViewDelegateFlowLayout {
    
    
    // 셀 크기 조정하기!! (스크린 사이즈를 잡아주고 들어가야, 모든 기기에서 동일한 비율을 얻을 수 있음)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds.width
        let cellWidth = (screenSize - 15) / 2 // 10하면 완전 합쳐짐
        let cellHeight = cellWidth * 1.5

        return CGSize(width: cellWidth, height: cellHeight)
    }

    // 라인 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 3
    }
    
    // 셀 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0 // 열 간의 간격을 0으로 설정하여 열과 열 사이에 간격이 없도록 합니다.
    }
}
