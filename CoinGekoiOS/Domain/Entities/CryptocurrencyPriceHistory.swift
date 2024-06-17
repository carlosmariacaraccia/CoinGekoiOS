//
//  CryptocurrencyPriceHistory.swift
//  CoinGekoiOS
//
//  Created by Carlos Caraccia on 6/17/24.
//

import Foundation

struct CryptocurrencyPriceHistory {
    let prices: [DataPoint]
    
    struct DataPoint {
        let price: Double
        let date: Date
    }
}
