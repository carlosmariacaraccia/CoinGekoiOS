//
//  GetPriceHistory.swift
//  CoinGekoiOS
//
//  Created by Carlos Caraccia on 6/17/24.
//

import Foundation

protocol IGetPriceHistory {
    func execute(id: String, days: Int) async -> Result<CryptocurrencyPriceHistory, CryptocurrencyDomainError>
}

class GetPriceHistory: IGetPriceHistory {
    
    private let cryptocurrencyPriceHistoryRepository: IRemoteCryptocurrencyPriceHistoryRepository
    
    init(cryptocurrencyPriceHistoryRepository: IRemoteCryptocurrencyPriceHistoryRepository) {
        self.cryptocurrencyPriceHistoryRepository = cryptocurrencyPriceHistoryRepository
    }
    
    func execute(id: String, days: Int) async -> Result<CryptocurrencyPriceHistory, CryptocurrencyDomainError> {
        await cryptocurrencyPriceHistoryRepository.getPriceHistory(id: id, days: days)
    }
}
