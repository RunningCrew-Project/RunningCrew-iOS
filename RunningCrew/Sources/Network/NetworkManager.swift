////
////  NetworkManager.swift
////  RunningCrew
////
////  Created by Kim TaeSoo on 2023/06/04.
////
//
//import Foundation
//import Alamofire
//
//class NetworkManager {
//    static let shared = NetworkManager()
//    static let mainurl = "https://runningcrew-test.ddns.net"
//    private init() {}
//    
//    func networkConnect(url: String, method: HTTPMethod, model: Codable) {
//        guard let url = URL(string: NetworkManager.mainurl + url) else { return }
//        
//        AF.request(url, method: method).responseDecodable(of: model.self) { response in
//            switch response.result {
//            case .success(let data):
//                print("네트워크 통신", data)
//            case .failure(let error):
//                print("statusCode", response.response?.statusCode)
//                print("네트워크 에러", error.localizedDescription)
//            }
//        }
//    }
//}
