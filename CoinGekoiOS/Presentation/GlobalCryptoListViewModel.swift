//
//  GlobalCryptoListViewModel.swift
//  CoinGekoiOS
//
//  Created by Carlos Caraccia on 6/5/24.
//

import Foundation
import SwiftUI

class GlobalCryptoListViewModel: ObservableObject {
    @Published var cryptos = [CryptocurrencyListPresentableItem]()
    
    private let getGlobalCryptoList: IGetGlobalCryptoList
    
    init(getGlobalCryptoList: IGetGlobalCryptoList) {
        self.getGlobalCryptoList = getGlobalCryptoList
    }
    
    @MainActor
    func onAppear() {
        Task {
            let cryptos = try? await self.getGlobalCryptoList.execute().get().map(CryptocurrencyListPresentableItem.init)
            guard let cryptos = cryptos else { return }
            self.cryptos = cryptos
        }
    }
}

// Type that we'll use to display inside the view model
struct CryptocurrencyListPresentableItem: Identifiable {
    let id: String
    let name: String
    let symbol: String
    let price: String
    var price24h: String
    var volume24h: String
    let marketCap: String
    
    init(domainModel: Cryptocurrency) {
        self.id = domainModel.id
        self.name = domainModel.name
        self.symbol = domainModel.symbol
        self.price = String(domainModel.price) + " $"
        self.marketCap = String(domainModel.marketCap) + " $"
        if let price24h = domainModel.price24h,
           let volume24h = domainModel.volume24h {
            self.price24h = String(price24h) + " $"
            self.volume24h = String(volume24h) + " $"
        } else {
            // we'll show a dash when there's not value
            self.price24h = "-"
            self.volume24h  = "-"
        }
    }

}
