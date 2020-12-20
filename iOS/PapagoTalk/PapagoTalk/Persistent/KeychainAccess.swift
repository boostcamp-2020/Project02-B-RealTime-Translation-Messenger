//
//  KeychainAccess.swift
//  PapagoTalk
//
//  Created by 송민관 on 2020/12/07.
//

import Foundation

struct KeychainAccess {
    
    static let shared = KeychainAccess(serviceName: "bundleID")

    let serviceName: String

    func get(forAccountKey account: String) -> String? {
        let query = baseQueryDictionary()
        query[kSecReturnData] = true
        query[kSecMatchLimit] = kSecMatchLimitOne
        query[kSecAttrAccount] = account
        
        var queryResult: AnyObject?
        
        let readStatus = SecItemCopyMatching(query, &queryResult)
        
        guard readStatus == errSecSuccess else {
            debugPrint(securityErrorMeesage(fromStatus: readStatus))
            return nil
        }
        
        guard let passwordData = queryResult as? Data else {
            debugPrint("Failed to convert query result to data")
            return nil
        }
        return String(data: passwordData, encoding: .utf8)
    }

    func set(_ value: String?, forAccountKey account: String) throws {
        guard let value = value else {
            try removeValue(forAccountKey: account)
            return
        }
        
        guard exists(forAccountKey: account) else {
            try insert(value, forAccountKey: account)
            return
        }
        try update(value, forAccountKey: account)
    }

    func exists(forAccountKey account: String) -> Bool {
        let query = baseQueryDictionary()
        query[kSecReturnData] = false
        query[kSecMatchLimit] = kSecMatchLimitOne
        query[kSecAttrAccount] = account
        
        let readStatus = SecItemCopyMatching(query, nil)
        
        guard readStatus == errSecSuccess else {
            debugPrint(securityErrorMeesage(fromStatus: readStatus))
            return false
        }
        return true
    }
    
    func removeValue(forAccountKey account: String) throws {
        let query = baseQueryDictionary()
        query[kSecAttrAccount] = account
        
        let deleteStatus = SecItemDelete(query)
        
        guard deleteStatus == errSecSuccess else {
            throw KeychainError.removeFailed(key: account, description: securityErrorMeesage(fromStatus: deleteStatus))
        }
    }

    func removeAll() throws {
        let deleteStatus = SecItemDelete(baseQueryDictionary())
        
        guard deleteStatus == errSecSuccess else {
            throw KeychainError.removeFailed(key: "ALL", description: securityErrorMeesage(fromStatus: deleteStatus))
        }
    }
    
    private func baseQueryDictionary() -> NSMutableDictionary {
        return [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: serviceName,
            kSecAttrAccessible: kSecAttrAccessibleAfterFirstUnlock
        ] as NSMutableDictionary
    }

    private func insert(_ value: String, forAccountKey account: String) throws {
        let query = baseQueryDictionary()
        query[kSecValueData] = value.data(using: .utf8)
        query[kSecAttrAccount] = account
        
        let saveStatus = SecItemAdd(query, nil)
        
        guard saveStatus == errSecSuccess else {
            throw KeychainError.insertFailed(key: account, description: securityErrorMeesage(fromStatus: saveStatus))
        }
    }

    private func update(_ value: String, forAccountKey account: String) throws {
        let query = baseQueryDictionary()
        query[kSecAttrAccount] = account
        
        let attributesToUpdate = [
            kSecValueData: value.data(using: .utf8)!,
            kSecAttrAccessible: kSecAttrAccessibleAfterFirstUnlock
        ] as NSDictionary
        
        let updateStatus = SecItemUpdate(query, attributesToUpdate)
        
        guard updateStatus == errSecSuccess else {
            throw KeychainError.updateFailed(key: account, description: securityErrorMeesage(fromStatus: updateStatus))
        }
    }

    private func securityErrorMeesage(fromStatus status: OSStatus) -> String {
        guard let errorMessage = SecCopyErrorMessageString(status, nil) else {
            return "error code: \(status)"
        }
        return errorMessage as String
    }
}
