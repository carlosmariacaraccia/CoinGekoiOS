//
//  CryptocurrencyDomainMapper.swift
//  CoinGekoiOS
//
//  Created by Carlos Caraccia on 6/4/24.
//

import Foundation

protocol ICryptocurrencyDomainMapper {
    func getCryptocurrencyBuilderList(symbolList: [String],cryptoList: [CryptocurrencyBasicDTO]) -> [CryptocurrencyBuilder]
    func map(builderList: [CryptocurrencyBuilder], priceInfo: [String: CryptoCurrencyPriceInfoDTO]) -> [Cryptocurrency]
}

class CryptocurrencyDomainMapper: ICryptocurrencyDomainMapper {
    func map(builderList: [CryptocurrencyBuilder], priceInfo: [String: CryptoCurrencyPriceInfoDTO]) -> [Cryptocurrency] {
        builderList.forEach {
            guard let priceInfo = priceInfo[$0.id] else { return }
            $0.price = priceInfo.price
            $0.volume24h = priceInfo.volume24h
            $0.marketCap = priceInfo.marketCap
            $0.price24h = priceInfo.price24h
        }
        return builderList.compactMap { $0.build() }
    }
    
    func getCryptocurrencyBuilderList(symbolList: [String], cryptoList: [CryptocurrencyBasicDTO]) -> [CryptocurrencyBuilder] {
        let symbolListDictionary = symbolList.reduce(into: [String: Bool]()) { $0[$1] = true }
        let globaCryptoList = cryptoList.filter { symbolListDictionary[$0.symbol] ?? false }
        return  globaCryptoList.map { CryptocurrencyBuilder(id: $0.id, symbol: $0.symbol, name: $0.name) }
    }
}
