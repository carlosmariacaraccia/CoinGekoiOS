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
