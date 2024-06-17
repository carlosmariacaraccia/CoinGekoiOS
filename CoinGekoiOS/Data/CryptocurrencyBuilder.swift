//
//  CryptocurrencyBuilder.swift
//  CoinGekoiOS
//
//  Created by Carlos Caraccia on 6/4/24.
//

import Foundation

class CryptocurrencyBuilder {
    let id: String
    let symbol: String
    let name: String
    var price: Double?
    var marketCap: Double?
    var volume24h: Double?
    var price24h: Double?
    
    init(id: String, symbol: String, name: String) {
        self.id = id
        self.symbol = symbol
        self.name = name
    }
    
    func build() -> Cryptocurrency? {
        guard let price, let marketCap, let volume24h, let price24h else { return nil }
        return Cryptocurrency(id: id, name: name, symbol: symbol, price: price, price24h: price24h, volume24h: volume24h, marketCap: marketCap)
    }
}
