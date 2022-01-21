//
//  KeychainSharingApp.swift
//  Shared
//
//  Created by Nick Cooke on 1/20/22.
//

import SwiftUI

@main
struct KeychainSharingApp: App {
    
    let keychainStorage = KeychainStorage(
        // FIXME: This should be updated in the following format:
        // <# Your Team ID #>.<#Keychain Sharing Group#>
        // Example: ABC1234567.com.your.keychain-sharing-group
        accessGroup: "{YOUR TEAM ID}.com.nickcooke.KeychainSharing.SharedItems",
        // These can remain the same.
        projectIdentifier: "project_identifier",
        keychainAccount: "shared_keychain_account"
    )
    
    var body: some Scene {
        WindowGroup {
            ContentView(keychainStorage: keychainStorage)
        }
    }
}
