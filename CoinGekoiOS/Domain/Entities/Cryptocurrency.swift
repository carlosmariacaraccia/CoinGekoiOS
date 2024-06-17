//
//  Cryptocurrency.swift
//  CoinGekoiOS
//
//  Created by Carlos Caraccia on 5/28/24.
//

import Foundation

struct Cryptocurrency {
    let id: String
    let name: String
    let symbol: String
    let price: Double
    var price24h: Double?
    var volume24h: Double?
    let marketCap: Double
}

// MARK: - Mocked data
extension Cryptocurrency {
    static let mockedData: Self = .init(
        id: "btc",
        name: "Bitcoin",
        symbol: "btc",
        price: 24000.43,
        price24h: 1.23,
        volume24h: 3400000,
        marketCap: 1340000
    )
}

