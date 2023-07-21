////
////  RunningNoticeManager.swift
////  RunningCrew
////
////  Created by Kim TaeSoo on 2023/06/04.
////
//
// import Foundation
//
//
// class RunningNoticeManager {
//    let mainURL = NetworkManager.mainurl
//    let id: String
//    var uri = "/api/running-notices/"
//    init (id: String) {
//        self.uri += id
//    }
//    func uploadFormData() {
//        let urlString =
//        
//        guard let url = URL(string: urlString) else {
//            print("Invalid URL")
//            return
//        }
//        
//        let parameters: [String: Any] = [
//            "title": "런닝 공지 제목",
//            "detail": "런닝 공지 내용",
//            "runningDateTime": "2023-06-04T10:00:00" // 예시 날짜 및 시간
//        ]
//        
//        Alamofire.upload(multipartFormData: { multipartFormData in
//            for (key, value) in parameters {
//                if let data = "\(value)".data(using: .utf8) {
//                    multipartFormData.append(data, withName: key)
//                }
//            }
//        }, to: url, method: .put) { result in
//            switch result {
//            case .success(let upload, _, _):
//                upload.responseJSON { response in
//                    // 응답 처리
//                    if let statusCode = response.response?.statusCode {
//                        print("Status Code: \(statusCode)")
//                    }
//                    
//                    if let resultData = response.result.value {
//                        print("Response Data: \(resultData)")
//                    }
//                }
//            case .failure(let error):
//                // 오류 처리
//                print("Upload Error: \(error)")
//            }
//        }
//    }
// }
