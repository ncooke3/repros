//
//  KeychainStorage.swift
//  KeychainSharing
//
//  Created by Nick Cooke on 1/21/22.
//

import Foundation

enum KeychainError: Error {
case saveError
case readError
case deleteError
}

final class KeychainStorage {
    private let accessGroup: String
    private let keychainAccount: String
    private let projectIdentifier: String
    
    init(accessGroup: String, projectIdentifier: String, keychainAccount: String) {
        self.accessGroup = accessGroup
        self.projectIdentifier = projectIdentifier
        self.keychainAccount = keychainAccount
    }

    func save(_ data: Data, syncAcrossDevices: Bool = false) throws {
        let attributes = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: projectIdentifier,
            kSecAttrAccount: keychainAccount,
            kSecAttrAccessGroup: accessGroup,
            kSecValueData: data,
            kSecAttrSynchronizable: syncAcrossDevices
        ] as [String: Any]
        
        let writeStatus: OSStatus = SecItemAdd(attributes as CFDictionary, nil)
        
        guard writeStatus == errSecSuccess else {
            throw KeychainError.saveError
        }
    }
    
    func load() throws -> Data {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: projectIdentifier,
            kSecAttrAccount: keychainAccount,
            kSecAttrAccessGroup: accessGroup,
            kSecReturnData: true,
            kSecAttrSynchronizable: kSecAttrSynchronizableAny
        ] as [String: Any]
        
        var item: CFTypeRef?
        let readStatus: OSStatus = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard readStatus == errSecSuccess, let itemData = item as? Data else {
            throw KeychainError.readError
        }
        
        return itemData
    }
    
    func delete() throws {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccessGroup: accessGroup,
            kSecAttrService: projectIdentifier,
            kSecAttrAccount: keychainAccount,
            kSecReturnData: true,
            kSecAttrSynchronizable: kSecAttrSynchronizableAny
        ] as [String: Any]
        
        let deleteStatus: OSStatus = SecItemDelete(query as CFDictionary)
        
        guard deleteStatus == errSecSuccess else {
            throw KeychainError.deleteError
        }
    }
}
