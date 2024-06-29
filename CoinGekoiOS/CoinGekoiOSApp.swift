//
//  CoinGekoiOSApp.swift
//  CoinGekoiOS
//
//  Created by Carlos Caraccia on 5/28/24.
//

import SwiftUI

@main
struct CoinGekoiOSApp: App {
    
    var body: some Scene {
        WindowGroup {
            GlobalCryptoListFactory.create()
        }
    }
}
