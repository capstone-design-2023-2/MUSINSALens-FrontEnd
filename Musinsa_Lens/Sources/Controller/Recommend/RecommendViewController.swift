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
    var recommendData: [RecommendData] = []
    
    
    // MARK: - IBOutlets
    @IBOutlet weak var RecommendCollectionView: UICollectionView!
    
    @IBOutlet var basicButton: UIButton!
    @IBOutlet var colorButton: UIButton!
    @IBOutlet var fitButton: UIButton!
    @IBOutlet var textureButton: UIButton!
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 콜렉션 뷰에 대한 설정
        RecommendCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        RecommendCollectionView.dataSource = self
        RecommendCollectionView.delegate = self
        
        // xib파일을 가져온다
        let myCustomCollectionViewCellNib = UINib(nibName: String(describing: RecommendCollectionViewCell.self), bundle: nil)

        
        // 가져온 닙파일로 콜렉션뷰에 셀로 등록한다
        self.RecommendCollectionView.register(myCustomCollectionViewCellNib, forCellWithReuseIdentifier: String(describing: RecommendCollectionViewCell.self))

        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // view가 다시 나타날때 collectionView 데이터 리로드
        RecommendCollectionView.reloadData()
        
        // 데이터 디버깅
        print(recommendData)
    }
    
    // MARK: - 데이터 가져오기
    
    func fetchData() {
        RecommendDataService.shared.getRecommendData_default { response in
            switch response {
            case .success(let data):
                if let response = data as? RecommendDataModel, let data = response.data {
                    self.recommendData = data
                    // 반드시 컬렉션뷰 리로드
                    self.RecommendCollectionView.reloadData()
                }
            case .requestErr(let message):
                print(message)
            case .networkFail:
                print("networkFail")
            case .serverErr:
                print("serverErr")
            case .pathErr:
                print("pathErr")
            case .decodingFail:
                print("decodingErr")
            }
        }
    }
    

}
// MARK: - Action
extension RecommendViewController {
    
    @IBAction func basicButtonTapped(_ sender: UIButton) {
        //case문 써가지고 4가지 상황으로 나누기
        RecommendDataService.shared.getRecommendData_default { response in
            switch response {
            case .success(let data):
                if let response = data as? RecommendDataModel, let data = response.data {
                    self.recommendData = data
                    // 반드시 컬렉션뷰 리로드
                    self.RecommendCollectionView.reloadData()
                }
            case .requestErr(let message):
                print(message)
            case .networkFail:
                print("networkFail")
            case .serverErr:
                print("serverErr")
            case .pathErr:
                print("pathErr")
            case .decodingFail:
                print("decodingErr")
            }
        }
    }
    
    @IBAction func colorButtonTapped(_ sender: UIButton) {
        //case문 써가지고 4가지 상황으로 나누기
        RecommendDataService.shared.getRecommendData_color { response in
            switch response {
            case .success(let data):
                // 받은 데이터를 RecommendDataModel로 캐스트할 수 있는지 확인
                if let response = data as? RecommendDataModel, let data = response.data {
                    self.recommendData = data   // 그 중 'data' 속성을 추출합니다

                    self.RecommendCollectionView.reloadData() //컬렉션뷰 리로드
                }
            case .requestErr(let message):
                print(message)
            case .networkFail:
                print("networkFail")
            case .serverErr:
                print("serverErr")
            case .pathErr:
                print("pathErr")
            case .decodingFail:
                print("decodingErr")
            }
        }
    }
    
    @IBAction func fitButtonTapped(_ sender: UIButton) {
        //case문 써가지고 4가지 상황으로 나누기
        RecommendDataService.shared.getRecommendData_fit { response in
            switch response {
            case .success(let data):
                if let response = data as? RecommendDataModel, let data = response.data {
                    self.recommendData = data
                    // 반드시 컬렉션뷰 리로드
                    self.RecommendCollectionView.reloadData()
                }
            case .requestErr(let message):
                print(message)
            case .networkFail:
                print("networkFail")
            case .serverErr:
                print("serverErr")
            case .pathErr:
                print("pathErr")
            case .decodingFail:
                print("decodingErr")
            }
        }
    }

    
    @IBAction func textureButtonTapped(_ sender: UIButton) {
        //case문 써가지고 4가지 상황으로 나누기
        RecommendDataService.shared.getRecommendData_texture { response in
            switch response {
            case .success(let data):
                if let response = data as? RecommendDataModel, let data = response.data {
                    self.recommendData = data
                    // 반드시 컬렉션뷰 리로드
                    self.RecommendCollectionView.reloadData()
                }
            case .requestErr(let message):
                print(message)
            case .networkFail:
                print("networkFail")
            case .serverErr:
                print("serverErr")
            case .pathErr:
                print("pathErr")
            case .decodingFail:
                print("decodingErr")
            }
        }
    }
}

// MARK: - UICollectionViewDataSource

extension RecommendViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.recommendData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: RecommendCollectionViewCell.self), for: indexPath) as! RecommendCollectionViewCell
        
        
        // 이미지 크기
        let cell_width = (UIScreen.main.bounds.width-15)/2
        cell.itemImageView.frame = CGRect(x: 0, y: 0, width: cell_width , height: cell_width)
        
        let recommendData = self.recommendData[indexPath.row]
        
        cell.setData(brandName: recommendData.brandName,
                     itemName: recommendData.itemName,
                     price: recommendData.price,
                     itemImage: recommendData.itemImage)
        
        /// 이미지뷰 설정
        //cell.itemImageView.image = UIImage(systemName: self.systemImageNameArray[indexPath.item])
        /// 텍스트뷰 설정
        //cell.brandLabel.text = self.systemImageNameArray[indexPath.item]
        //cell.contentView.backgroundColor = UIColor.blue
        
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
        let cellWidth = (screenSize - 10) / 2 // 10하면 완전 합쳐짐
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
