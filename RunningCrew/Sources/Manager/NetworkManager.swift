//
//  NetworkManager.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/07/21.
//

import Foundation
import Alamofire

final class NetworkManager {
    static let shared = NetworkManager()
    static let mainURL = "https://runningcrew-test.ddns.net"
    
    private init() {}
}
