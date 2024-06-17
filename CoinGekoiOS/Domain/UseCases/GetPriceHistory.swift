//
//  GetPriceHistory.swift
//  CoinGekoiOS
//
//  Created by Carlos Caraccia on 6/17/24.
//

import Foundation


class GetPriceHistory {
    
    let cryptocurrencyPriceHistoryRepository: ICryptocurrencyPriceHistoryRepository
    
    init(cryptocurrencyPriceHistoryRepository: ICryptocurrencyPriceHistoryRepository) {
        self.cryptocurrencyPriceHistoryRepository = cryptocurrencyPriceHistoryRepository
    }
    
    
    func execute(id: String, days: Int) async -> Result<CrytocurrencyPriceHistory, CryptocurrencyDomainError> {
       await cryptocurrencyPriceHistoryRepository.getPriceHistory(id: id, days: days)
    }
}
