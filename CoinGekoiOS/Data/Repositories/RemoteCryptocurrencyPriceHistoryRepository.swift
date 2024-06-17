//
//  RemoteCryptocurrencyPriceHistoryRepository.swift
//  CoinGekoiOS
//
//  Created by Carlos Caraccia on 6/17/24.
//

import Foundation

class CryptocurrencyPriceHistoryDomainMapper {
    func map(cryptocurrencyPriceHistoryDTO: CryptocurrencyPriceHistoryDTO) -> CryptocurrencyPriceHistory {
        let prices = cryptocurrencyPriceHistoryDTO.prices.compactMap({ dataPoint in
            let price = (dataPoint[1] * 100).rounded() / 100 // round to two decimal places
            let date = Date(timeIntervalSince1970: dataPoint[0] / 1000)
            return CryptocurrencyPriceHistory.DataPoint(price: price, date: date)
        })
        return CryptocurrencyPriceHistory(prices: prices)
    }
}

protocol IRemoteCryptocurrencyPriceHistoryRepository {
    func getPriceHistory(id: String, days: Int) async -> Result<CryptocurrencyPriceHistory, CryptocurrencyDomainError>
}

class RemoteCryptocurrencyPriceHistoryRepository: IRemoteCryptocurrencyPriceHistoryRepository {
    
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
    
    func getPriceHistory(id: String, days: Int) async -> Result<CryptocurrencyPriceHistory, CryptocurrencyDomainError> {
        let result = await apiDataSource.getPriceHistory(id: id, days: days)
        guard case .success(let priceHistory) = result else {
            return .failure(errorMapper.map(error: result.failureError as? HTTPClientError))
        }
        
        return .success(domainMapper.map(cryptocurrencyPriceHistoryDTO: priceHistory))
    }
}
