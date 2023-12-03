//
//  RecommendDataModel.swift
//  Musinsa_Lens
//
//  Created by 박예린 on 2023/12/02.
//

import Foundation
import Alamofire
import UIKit

// MARK: - GetPersonDataService
// 추천 데이터 서비스를 담당하는 구조체
struct RecommendDataService {
    
    // Singleton 패턴: 하나의 인스턴스를 앱 전체에서 공유할 수 있도록 함
    static let shared = RecommendDataService()
    
    // 서버로부터 추천 데이터를 가져오는 함수
    func getRecommendData(completion: @escaping (NetworkResult<Any>) -> ()) {
        // 서버 URL
        let url = "http://3.38.212.123:8000/rest/upload"
        
        // 사용자가 선택한 기준
        let sort_criterion = "color"
        // 사용자가 업로드한 이미지
        let image = UIImage(named: "/Users/roadhs/Downloads/1.png")!
        
        AF.upload(multipartFormData: { multipartData in
            // sort_criteria를 키로 하는 텍스트 데이터 추가
            multipartData.append(sort_criterion.data(using: .utf8)!, withName: "sort_criterion")
            
            // image를 키로 하는 이미지 데이터를 추가
            if let imageData = image.jpegData(compressionQuality: 1.0) {
                multipartData.append(imageData, withName: "file", fileName: "image.jpg", mimeType: "image/jpeg")
            }
        }, to: url, method: .post, headers: ["Content-Type": "multipart/form-data"])
        .responseJSON { response in
            switch response.result {
            case .success(let value):
                
                // 성공적으로 JSON을 수신한 경우
                print("JSON Response: \(value)")
                
                // 만약 JSON이 Dictionary 형태로 사용되는 경우
                if let jsonDictionary = value as? [String: Any] {
                    // jsonDictionary를 사용하여 필요한 작업 수행
                    print("Value of key 'example': \(jsonDictionary["example"] ?? "N/A")")
                }
                
            case .failure(let error):
                // 요청이 실패한 경우
                print("Error: \(error)")
            }
        }
    }
}
