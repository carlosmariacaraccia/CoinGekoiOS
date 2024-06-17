//
//  CoinGekoiOSApp.swift
//  CoinGekoiOS
//
//  Created by Carlos Caraccia on 5/28/24.
//

import SwiftUI

@main
struct CoinGekoiOSApp: App {
    let root = GlobalCryptoListFactory.createUseCase()
    
    var body: some Scene {
        WindowGroup {
            GlobalCryptoListView(
                viewModel: .init(
                    getGlobalCryptoList: root,
                    errorMapper: CryptocurrencyPresentableErrorMapper()
                )
            )
        }
    }
}
