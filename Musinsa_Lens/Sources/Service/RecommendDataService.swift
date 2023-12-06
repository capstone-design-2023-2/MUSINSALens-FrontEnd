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
    
    
    //    func getRecommendData_color(completion: @escaping (NetworkResult<Any>) -> ()) {
    //
    //        let url = "http://3.38.212.123:8000/rest/upload"
    //        let sort_criterion = "color"
    //        let image = UIImage(named: "/Users/yerin/Documents/pyerin/iOS_RF/item_sample.png")!
    //        let header: HTTPHeaders = ["Content-Type" : "multipart/form-data"]
    //
    //
    //        AF.upload(multipartFormData: { multipartData in
    //            multipartData.append(sort_criterion.data(using: .utf8)!, withName: "sort_criterion")
    //
    //            if let imageData = image.jpegData(compressionQuality: 1.0) {
    //                multipartData.append(imageData, withName: "file", fileName: "image.jpg", mimeType: "image/jpeg")
    //            }
    //        }, to: url, method: .post, headers: header)
    //
    //        .responseDecodable(of: RecommendDataModel.self)  { response in
    //            switch response.result {
    //
    //            case .success(let value):
    //                print("JSON Response: \(value)")
    //
    //
    //
    //            case .failure(let error):
    //                print("Error: \(error)")
    //            }
    //        }
    //    }
    
    
    // 테스트용
    func getRecommendData_color(completion: @escaping (NetworkResult<Any>) -> ()) {
        
        let url = "http://3.38.212.123:8000/rest/upload"
        let sort_criterion = "color"
        let image = UIImage(named: "/Users/yerin/Documents/pyerin/iOS_RF/item_sample.png")!
        let header: HTTPHeaders = ["Content-Type" : "multipart/form-data"]
        
        
        AF.upload(multipartFormData: { multipartData in
            multipartData.append(sort_criterion.data(using: .utf8)!, withName: "sort_criterion")
            
            if let imageData = image.jpegData(compressionQuality: 1.0) {
                multipartData.append(imageData, withName: "file", fileName: "image.jpg", mimeType: "image/jpeg")
            }
        }, to: url, method: .post, headers: header)
        
        .responseData  { dataResponse in
            switch dataResponse.result {
            case .success(_):
                // 성공한 경우 응답의 상태 코드와 데이터를 가져옴
                guard let statusCode = dataResponse.response?.statusCode else { return }
                guard let data = dataResponse.value else { return }
                
                if let json = try? JSONSerialization.jsonObject(with: data, options: []),
                   JSONSerialization.isValidJSONObject(json) {
                    // 데이터가 유효한 JSON인 경우
                    let networkResult = self.judgeRecommendStatus(status: statusCode, data: data)
                    completion(networkResult)
                    print("JSON맞음")
                } else {
                    // 데이터가 유효한 JSON이 아닌 경우
                    print("JSON아님")
                }
                
            case .failure(_):
                // 실패한 경우 네트워크 에러로 간주하고 pathErr 반환
                completion(.pathErr)
            }
        }
    }
    
    
    func getRecommendData_fit(completion: @escaping (NetworkResult<Any>) -> ()) {
        
        let url = "http://3.38.212.123:8000/rest/upload"
        let sort_criterion = "hog"
        let image = UIImage(named: "/Users/yerin/Documents/pyerin/iOS_RF/item_sample.png")!
        
        AF.upload(multipartFormData: { multipartData in
            multipartData.append(sort_criterion.data(using: .utf8)!, withName: "sort_criterion")
            
            if let imageData = image.jpegData(compressionQuality: 1.0) {
                multipartData.append(imageData, withName: "file", fileName: "image.jpg", mimeType: "image/jpeg")
            }
        }, to: url, method: .post, headers: ["Content-Type": "multipart/form-data"])
        .responseJSON { response in
            switch response.result {
                
            case .success(let value):
                print("JSON Response: \(value)")
                
                if let jsonDictionary = value as? [String: Any] {
                    print("Value of key 'example': \(jsonDictionary["example"] ?? "N/A")")
                }
                
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    
    func getRecommendData_texture(completion: @escaping (NetworkResult<Any>) -> ()) {
        
        let url = "http://3.38.212.123:8000/rest/upload"
        let sort_criterion = "gabor"
        let image = UIImage(named: "/Users/yerin/Documents/pyerin/iOS_RF/item_sample.png")!
        
        AF.upload(multipartFormData: { multipartData in
            multipartData.append(sort_criterion.data(using: .utf8)!, withName: "sort_criterion")
            
            if let imageData = image.jpegData(compressionQuality: 1.0) {
                multipartData.append(imageData, withName: "file", fileName: "image.jpg", mimeType: "image/jpeg")
            }
        }, to: url, method: .post, headers: ["Content-Type": "multipart/form-data"])
        .responseJSON { response in
            switch response.result {
                
            case .success(let value):
                print("JSON Response: \(value)")
                
                if let jsonDictionary = value as? [String: Any] {
                    print("Value of key 'example': \(jsonDictionary["example"] ?? "N/A")")
                }
                
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    
    
    //    // 서버 응답 상태 코드에 따라 결과를 판단하는 함수
    //    private func judgeRecommendStatus(status: Int, data: Data) -> NetworkResult<Any> {
    //        // JSON 데이터를 디코딩하기 위해 JSONDecoder 사용
    //        let decoder = JSONDecoder()
    //
    //        // 서버 응답 데이터를 RecommendDataModel로 디코딩
    //        guard let decodeData = try? decoder.decode(RecommendData.self, from: data)
    //        else { return .decodingFail }
    //
    //        // 디코딩에 성공한 경우 해당 데이터를 성공 케이스로 반환
    //        return .success(decodeData)
    //    }
    //}
    
    // 서버 응답 상태 코드에 따라 결과를 판단하는 함수
    private func judgeRecommendStatus(status: Int, data: Data) -> NetworkResult<Any> {
        switch status {
        case 200: return isValidData(data: data)
        case 400: return isUsedPathErrData(data: data)
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    private func isValidData(data: Data) -> NetworkResult<Any> {
        
        let decoder = JSONDecoder()
        
        guard let decodedData = try? decoder.decode(RecommendDataModel.self, from: data) else {return .pathErr}
        return .success(decodedData)
    }
    
    private func isUsedPathErrData(data: Data)  -> NetworkResult<Any> {
        
        let decoder = JSONDecoder()
        
        guard let decodedData = try? decoder.decode(RecommendDataModel.self, from: data) else {return .pathErr}
        return .requestErr(decodedData)
    }
}
