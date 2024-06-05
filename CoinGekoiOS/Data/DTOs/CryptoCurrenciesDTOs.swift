//
//  CryptoCurrenciesDTOs.swift
//  CoinGekoiOS
//
//  Created by Carlos Caraccia on 5/29/24.
//

import Foundation

// MARK: - CryptoCurrencyPriceInfoDTO
struct CryptoCurrencyPriceInfoDTO: Codable {
    let price: Double
    let marketCap: Double
    let volume24h: Double
    let price24h: Double
    
    enum CodingKeys: String, CodingKey {
        case price = "usd"
        case marketCap = "usd_market_cap"
        case volume24h = "usd_24h_vol"
        case price24h = "usd_24h_change"
    }
}

// MARK: - CryptoCurrencyBasicDTO
struct CryptocurrencyBasicDTO: Codable {
    let id: String
    let symbol: String
    let name: String
    
    enum CodingKeys: CodingKey {
        case id
        case symbol
        case name
    }
}

// MARK: - CryptocurrencyGlobalInfoDTO
struct CryptocurrecyGlobalInfoDTO: Codable {
    let data: CryptocurrecyGlobalData
    
    struct CryptocurrecyGlobalData: Codable {
        let cryptocurrencies: [String: Double]
        
        enum CodingKeys: String, CodingKey {
            case cryptocurrencies = "market_cap_percentage"
        }
    }
}
