//
//  CryptocurrencyPriceHistoryRepository.swift
//  CoinGekoiOS
//
//  Created by Carlos Caraccia on 6/17/24.
//

import Foundation

class CryptocurrencyPriceHistoryDomainMapper {
    func map(cryptocurrencyPriceHistoryDTO: CryptocurrencyPriceHistoryDTO) -> CrytocurrencyPriceHistory {
        fatalError()
    }
}

protocol ICryptocurrencyPriceHistoryRepository {
    func getPriceHistory(id: String, days: Int) async -> Result<CrytocurrencyPriceHistory, CryptocurrencyDomainError>
}

class CryptocurrencyPriceHistoryRepository: ICryptocurrencyPriceHistoryRepository {
    
    private let apiDataSource: IAPIPriceHistoryDataSource
    private let domainMapper: CryptocurrencyPriceHistoryDomainMapper
    private let errorMapper: CryptoCurrencyDomainErrorMapper
    
    init(
        apiDataSource: IAPIPriceHistoryDataSource,
        domainMapper: CryptocurrencyPriceHistoryDomainMapper,
        errorMapper: CryptoCurrencyDomainErrorMapper
    ) {
        self.apiDataSource = apiDataSource
        self.domainMapper = domainMapper
        self.errorMapper = errorMapper
    }
    
    func getPriceHistory(id: String, days: Int) async -> Result<CrytocurrencyPriceHistory, CryptocurrencyDomainError> {
        let result = await apiDataSource.getPriceHistory(id: id, days: days)
        guard case .success(let priceHistory) = result else {
            return .failure(errorMapper.map(error: result.failureError as? HTTPClientError))
        }
        
        return .success(domainMapper.map(cryptocurrencyPriceHistoryDTO: priceHistory))

        
    }
}
