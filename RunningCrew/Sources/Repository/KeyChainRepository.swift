//
//  KeyChainRepository.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/07/24.
//

import Foundation
import Security

final class KeyChainRepository {
    
    static let shared = KeyChainRepository()
    
    private init() { }
    
    func readToken(key: String) throws -> String {
        let readQuery: NSDictionary = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: key,
            kSecReturnData: kCFBooleanTrue!,
            kSecMatchLimit: kSecMatchLimitOne]
        
        var item: CFTypeRef?
        
        if SecItemCopyMatching(readQuery, &item) != errSecSuccess {
            throw KeyChainError.readToken
        }
        
        guard let data = item as? Data,
              let token = String(data: data, encoding: .utf8)
        else { throw KeyChainError.readToken }
        
        return token
    }
    
    func saveToken(key: String, value: String) -> Bool {
        let saveQuery: [CFString: Any] = [kSecClass: kSecClassKey,
            kSecAttrApplicationTag: key,
            kSecValueData: value.data(using: .utf8)!
            ]
        
        return SecItemAdd(saveQuery as CFDictionary, nil) == errSecSuccess
    }
    
    func updateToken(key: String, newValue: String) -> Bool {
        let updateQuery: [CFString: Any] = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: key
        ]
        
        let attributes: [CFString: Any] = [
            kSecValueData: newValue
        ]

        return SecItemUpdate(updateQuery as CFDictionary, attributes as CFDictionary) == errSecSuccess
    }
    
    func deleteToken(key: String) -> Bool {
        let deleteQuery: [CFString: Any] = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: key
        ]
        
        return SecItemDelete(deleteQuery as CFDictionary) == errSecSuccess
    }
}
