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
    
    func generateUniqueFileName() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd_HHmmssSSS"
        let currentDateTime = Date()
        let fileName = formatter.string(from: currentDateTime)
        return "\(fileName).jpg"
    }
    
    func getRecommendData_default(image: UIImage, completion: @escaping (NetworkResult<Any>) -> ()) {
        
        guard let imageData = image.jpegData(compressionQuality: 1.0) else {
            print("Error: imageData is nil")
            completion(.pathErr)
            return
        }
        // 서버 URL
        let url = "http://54.180.98.175:8000/rest/upload"
        
        // 사용자가 선택한 기준
        let sort_criterion = "vgg"
        // 사용자가 업로드한 이미지
        //let image = UIImage(named: "/Users/yerin/Documents/pyerin/iOS_RF/item_sample.png")!
        let header: HTTPHeaders = ["Content-Type" : "multipart/form-data"]

        
        // Alamofire의 AF.upload를 사용하여 멀티파트 폼 데이터 요청을 처리
        AF.upload(multipartFormData: { multipartData in
            multipartData.append(sort_criterion.data(using: .utf8)!, withName: "sort_criterion")
            
            if let imageData = image.jpegData(compressionQuality: 1.0) {
                let fileName = generateUniqueFileName()
                multipartData.append(imageData, withName: "file", fileName: fileName, mimeType: "image/jpeg")
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
    
    
    func getRecommendData_fit(image: UIImage, completion: @escaping (NetworkResult<Any>) -> ()) {
        
        guard let imageData = image.jpegData(compressionQuality: 1.0) else {
            print("Error: imageData is nil")
            completion(.pathErr)
            return
        }
        // 서버 URL
        let url = "http://54.180.98.175:8000/rest/upload"
        
        // 사용자가 선택한 기준
        let sort_criterion = "hog"
        // 사용자가 업로드한 이미지
        //let image = UIImage(named: "/Users/yerin/Documents/pyerin/iOS_RF/item_sample.png")!
        let header: HTTPHeaders = ["Content-Type" : "multipart/form-data"]

        
        // Alamofire의 AF.upload를 사용하여 멀티파트 폼 데이터 요청을 처리
        AF.upload(multipartFormData: { multipartData in
            multipartData.append(sort_criterion.data(using: .utf8)!, withName: "sort_criterion")
            
            if let imageData = image.jpegData(compressionQuality: 1.0) {
                let fileName = generateUniqueFileName()
                multipartData.append(imageData, withName: "file", fileName: fileName, mimeType: "image/jpeg")
            }
        }, to: url, method: .post, headers: header)
        
        .responseData  { dataResponse in
            switch dataResponse.result {
            case .success(_):
                
                guard let statusCode = dataResponse.response?.statusCode else { return }
                guard let data = dataResponse.value else { return }
                
                if let json = try? JSONSerialization.jsonObject(with: data, options: []),
                   JSONSerialization.isValidJSONObject(json) {
                    
                    let networkResult = self.judgeRecommendStatus(status: statusCode, data: data)
                    completion(networkResult)
                    
                    print("JSON맞음")
                } else {
                    
                    print("JSON아님")
                }
                
            case .failure(_):
                
                completion(.pathErr)
            }
        }
    }
    
    
    func getRecommendData_texture(image: UIImage, completion: @escaping (NetworkResult<Any>) -> ()) {
        
        guard let imageData = image.jpegData(compressionQuality: 1.0) else {
            print("Error: imageData is nil")
            completion(.pathErr)
            return
        }
        // 서버 URL
        let url = "http://54.180.98.175:8000/rest/upload"
        
        // 사용자가 선택한 기준
        let sort_criterion = "gabor"
        // 사용자가 업로드한 이미지
        //let image = UIImage(named: "/Users/yerin/Documents/pyerin/iOS_RF/item_sample.png")!
        let header: HTTPHeaders = ["Content-Type" : "multipart/form-data"]

        
        // Alamofire의 AF.upload를 사용하여 멀티파트 폼 데이터 요청을 처리
        AF.upload(multipartFormData: { multipartData in
            multipartData.append(sort_criterion.data(using: .utf8)!, withName: "sort_criterion")
            
            if let imageData = image.jpegData(compressionQuality: 1.0) {
                let fileName = generateUniqueFileName()
                multipartData.append(imageData, withName: "file", fileName: fileName, mimeType: "image/jpeg")
            }
        }, to: url, method: .post, headers: header)
        
        .responseData  { dataResponse in
            switch dataResponse.result {
            case .success(_):
               
                guard let statusCode = dataResponse.response?.statusCode else { return }
                guard let data = dataResponse.value else { return }
                
                if let json = try? JSONSerialization.jsonObject(with: data, options: []),
                   JSONSerialization.isValidJSONObject(json) {
                    
                    let networkResult = self.judgeRecommendStatus(status: statusCode, data: data)
                    completion(networkResult)
                    
                    print("JSON맞음")
                } else {
                    
                    print("JSON아님")
                }
                
            case .failure(_):
               
                completion(.pathErr)
            }
        }
    }
    
    
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
