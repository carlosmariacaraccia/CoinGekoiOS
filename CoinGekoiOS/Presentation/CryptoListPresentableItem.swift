//
//  CryptoListPresentableItem.swift
//  CoinGekoiOS
//
//  Created by Carlos Caraccia on 6/17/24.
//

import Foundation

// Type that we'll use to display inside the view model
struct CryptocurrencyListPresentableItem: Identifiable {
    let id: String
    let name: String
    let symbol: String
    let price: String
    var price24h: String
    var volume24h: String
    let marketCap: String
    let isPriceChangePositive: Bool
    
    init(domainModel: Cryptocurrency) {
        self.id = domainModel.id
        self.name = domainModel.name
        self.symbol = domainModel.symbol
        self.price = String(domainModel.price) + " $"
        self.marketCap = String(domainModel.marketCap.twoDecimalPlacesFormatted()) + " $"
        if let price24h = domainModel.price24h, let volume24h = domainModel.volume24h {
            self.volume24h = String(volume24h.twoDecimalPlacesFormatted()) + " $"
            self.isPriceChangePositive = price24h > 0
            self.price24h = "\(isPriceChangePositive ? "+" : "")" + String(price24h.twoDecimalPlacesFormatted()) + " %"
        } else {
            // we'll show a dash when there's not value
            self.price24h = "-"
            self.volume24h  = "-"
            self.isPriceChangePositive = true
        }
    }
}
