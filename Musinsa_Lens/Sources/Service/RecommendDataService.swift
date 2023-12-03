//
//  RecommendDataModel.swift
//  Musinsa_Lens
//
//  Created by 박예린 on 2023/12/02.
//

import Foundation
import Alamofire

// MARK: - GetPersonDataService
// 추천 데이터 서비스를 담당하는 구조체
struct RecommendDataService {
    
    // Singleton 패턴: 하나의 인스턴스를 앱 전체에서 공유할 수 있도록 함
    static let shared = RecommendDataService()
    
    // 서버로부터 추천 데이터를 가져오는 함수
    func getRecommendData(completion: @escaping (NetworkResult<Any>) -> ()) {
        
        // 서버의 추천 데이터 엔드포인트 URL
        let url = "http://3.38.212.123:8000"
        
        // HTTP 헤더 설정
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        
        // Alamofire를 사용하여 서버에 GET 요청
        let dataRequest = AF.request(url,
                                     method: .get,
                                     encoding: JSONEncoding.default,
                                     headers: headers)
        
        // 서버 응답 처리
        dataRequest.responseData { dataResponse in
            
            switch dataResponse.result {
            case .success(_):
                // 성공한 경우 응답의 상태 코드와 데이터를 가져옴
                guard let statusCode = dataResponse.response?.statusCode else { return }
                guard let data = dataResponse.value else { return }
                
                // 결과를 판단하여 완료 핸들러 호출
                let networkResult = self.judgeStatus(status: statusCode,
                                                         data: data)
                completion(networkResult)
                
            case .failure(_):
                // 실패한 경우 네트워크 에러로 간주하고 pathErr 반환
                completion(.pathErr)
            }
        }
    }
    
    // 서버 응답 상태 코드에 따라 결과를 판단하는 함수
    private func judgeStatus(status: Int, data: Data) -> NetworkResult<Any> {
        // JSON 데이터를 디코딩하기 위해 JSONDecoder 사용
        let decoder = JSONDecoder()
        
        // 서버 응답 데이터를 RecommendDataModel로 디코딩
        guard let decodeData = try? decoder.decode(RecommendDataModel.self, from: data)
        else { return .pathErr }

        // 디코딩에 성공한 경우 해당 데이터를 성공 케이스로 반환
        return .success(decodeData)
    }
}
