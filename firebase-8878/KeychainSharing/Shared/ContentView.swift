//
//  ContentView.swift
//  Shared
//
//  Created by Nick Cooke on 1/20/22.
//

import SwiftUI

struct ContentView: View {
    let keychainStorage: KeychainStorage

    @State private var password: String = ""
    
    var body: some View {
        
        VStack {
            TextField("Enter a password to sync across devices.", text: $password)
                            
            Button("Save password") {
                guard let passwordData = password.data(using: .utf8) else {
                    print("Password data was empty– it will not be saved.")
                    return
                }
                
                do {
                    try keychainStorage.save(passwordData, syncAcrossDevices: true)
                    print("Password successfully saved: \(password)")
                } catch {
                    print("Password failed to save.")
                }
            }
            .padding(.bottom)
            
            Button("Print saved password to console") {
                guard
                    let passwordData = try? keychainStorage.load(),
                    let password = String(data: passwordData, encoding: .utf8)
                else {
                    print("Password could not be retrieved.")
                    return
                }
                
                print("Password successfully retrieved: \(password)")
            }
            
            Button("Delete saved password") {
                do {
                    try keychainStorage.delete()
                    print("Password successfully deleted.")
                } catch {
                    print("Password could not be deleted.")
                }
            }
        }
    }
}

