//
//  RecommendDataModel.swift
//  Musinsa_Lens
//
//  Created by 박예린 on 2023/12/02.
//

import Foundation
import Alamofire
import UIKit

// MARK: - GetRecommendDataService
// 추천 데이터 서비스를 담당하는 구조체
struct RecommendDataService {
    
    // Singleton 패턴: 하나의 인스턴스를 앱 전체에서 공유할 수 있도록 함
    static let shared = RecommendDataService()
    
//    func getRecommendData_basic(completion: @escaping (NetworkResult<Any>) -> ()) {
//        // 서버 URL
//        let url = "http://3.38.212.123:8000/rest/upload"
//
//        // 사용자가 선택한 기준
//        let sort_criterion = "color"
//        // 사용자가 업로드한 이미지
//        let image = UIImage(named: "/Users/yerin/Documents/pyerin/iOS_RF/item_sample.png")!
//
//        // Alamofire의 AF.upload를 사용하여 멀티파트 폼 데이터 요청을 처리
//        let dataRequest = AF.upload(multipartFormData: { multipartData in
//
//            // sort_criteria를 텍스트데이터로 요청데이터에 추가
//            multipartData.append(sort_criterion.data(using: .utf8)!, withName: "sort_criterion")
//
//            // UIImage를 JPEG 데이터로 변환할 수 있는지 확인하고 요청 데이터에 추가
//            if let imageData = image.jpegData(compressionQuality: 1.0) {
//                multipartData.append(imageData, withName: "file", fileName: "image.jpg", mimeType: "image/jpeg")
//            }
//        },to: url, method: .post, headers: ["Content-Type": "multipart/form-data"])
//
//
//        dataRequest.responseData { dataResponse in
//            switch dataResponse.result {
//
//            // 요청 성공한 경우
//            case .success(let value):
//                print("JSON Response: \(value)")
//                guard let statusCode = dataResponse.response?.statusCode else {return}
//                guard let value = dataResponse.value else {return}
//                let networkResult = self.judgeStatus(by: statusCode, value)
//                completion(networkResult)
//
//            // 요청 실패한 경우
//            case .failure(let error):
//                print("Error: \(error)")
//            }
//        }
//    }
    
    func getRecommendData_default(completion: @escaping (NetworkResult<Any>) -> ()) {
        // 서버 URL
        let url = "http://3.38.212.123:8000/rest/upload"
        
        // 사용자가 선택한 기준
        let sort_criterion = "vgg"
        // 사용자가 업로드한 이미지
        let image = UIImage(named: "/Users/yerin/Documents/pyerin/iOS_RF/item_sample.png")!
        
        // Alamofire의 AF.upload를 사용하여 멀티파트 폼 데이터 요청을 처리
        AF.upload(multipartFormData: { multipartData in
            // sort_criteria를 텍스트데이터로 요청데이터에 추가
            multipartData.append(sort_criterion.data(using: .utf8)!, withName: "sort_criterion")
            
            // UIImage를 JPEG 데이터로 변환할 수 있는지 확인하고 요청 데이터에 추가
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
    
    func getRecommendData_color(completion: @escaping (NetworkResult<Any>) -> ()) {
        // 서버 URL
        let url = "http://3.38.212.123:8000/rest/upload"
        
        // 사용자가 선택한 기준
        let sort_criterion = "color"
        // 사용자가 업로드한 이미지
        let image = UIImage(named: "/Users/yerin/Documents/pyerin/iOS_RF/item_sample.png")!
        
        // Alamofire의 AF.upload를 사용하여 멀티파트 폼 데이터 요청을 처리
        AF.upload(multipartFormData: { multipartData in
            // sort_criteria를 텍스트데이터로 요청데이터에 추가
            multipartData.append(sort_criterion.data(using: .utf8)!, withName: "sort_criterion")
            
            // UIImage를 JPEG 데이터로 변환할 수 있는지 확인하고 요청 데이터에 추가
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
    func getRecommendData_fit(completion: @escaping (NetworkResult<Any>) -> ()) {
        // 서버 URL
        let url = "http://3.38.212.123:8000/rest/upload"
        
        // 사용자가 선택한 기준
        let sort_criterion = "hog"
        // 사용자가 업로드한 이미지
        let image = UIImage(named: "/Users/yerin/Documents/pyerin/iOS_RF/item_sample.png")!
        
        // Alamofire의 AF.upload를 사용하여 멀티파트 폼 데이터 요청을 처리
        AF.upload(multipartFormData: { multipartData in
            // sort_criteria를 텍스트데이터로 요청데이터에 추가
            multipartData.append(sort_criterion.data(using: .utf8)!, withName: "sort_criterion")
            
            // UIImage를 JPEG 데이터로 변환할 수 있는지 확인하고 요청 데이터에 추가
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
    func getRecommendData_texture(completion: @escaping (NetworkResult<Any>) -> ()) {
        // 서버 URL
        let url = "http://3.38.212.123:8000/rest/upload"
        
        // 사용자가 선택한 기준
        let sort_criterion = "gabor"
        // 사용자가 업로드한 이미지
        let image = UIImage(named: "/Users/yerin/Documents/pyerin/iOS_RF/item_sample.png")!
        
        // Alamofire의 AF.upload를 사용하여 멀티파트 폼 데이터 요청을 처리
        AF.upload(multipartFormData: { multipartData in
            // sort_criteria를 텍스트데이터로 요청데이터에 추가
            multipartData.append(sort_criterion.data(using: .utf8)!, withName: "sort_criterion")
            
            // UIImage를 JPEG 데이터로 변환할 수 있는지 확인하고 요청 데이터에 추가
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
    
    
    
    
//    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
//        switch statusCode {
//
//        case 200: return isValidData(data: data)
//        case 400: return .pathErr
//        case 500: return .serverErr
//        default: return .networkFail
//        }
//    }
//
//    private func isValidData(data : Data) -> NetworkResult<Any> {
//
//        let decoder = JSONDecoder()
//
//        guard let decodedData = try? decoder.decode(RecommendDataModel.self, from: data)
//        else { return .pathErr}
//        // 우선 PersonDataModel 형태로 decode(해독)을 한번 거칩니다. 실패하면 pathErr
//        // 해독에 성공하면 Person data를 success에 넣어줍니다.
//        return .success(decodedData.data!)
//    }
}

