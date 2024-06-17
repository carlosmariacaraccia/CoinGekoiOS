//
//  RemoteCryptoCurrencyRepostiory.swift
//  CoinGekoiOS
//
//  Created by Carlos Caraccia on 5/28/24.
//

import Foundation

protocol IRemoteCryptoCurrencyRepostiory {
    func getGlobalCryptoList() async -> Result<[Cryptocurrency], CryptocurrencyDomainError>
}

class RemoteCryptoCurrencyRepostiory: IRemoteCryptoCurrencyRepostiory {
    private let apiDataSource: IAPIDataSource
    private let errorMapper: ICryptoCurrencyDomainErrorMapper
    private let domainMapper: ICryptocurrencyDomainMapper
    
    init(
        apiDataSource: IAPIDataSource,
        errorMapper: ICryptoCurrencyDomainErrorMapper,
        domainMapper: ICryptocurrencyDomainMapper
    ) {
        self.apiDataSource = apiDataSource
        self.errorMapper = errorMapper
        self.domainMapper = domainMapper
    }
    
    func getGlobalCryptoList() async -> Result<[Cryptocurrency], CryptocurrencyDomainError> {
        let symbolListResult = await apiDataSource.getGlobalCryptoList()
        let cryptoListResult = await apiDataSource.getCryptoList()
        
        guard case .success(let symbolList) = symbolListResult else {
            return .failure(errorMapper.map(error: symbolListResult.failureError as? HTTPClientError))
        }
        
        guard case .success(let cryptoList) = cryptoListResult else {
            return .failure(errorMapper.map(error: cryptoListResult.failureError as? HTTPClientError))
        }
        
        let cryptocurrenciesBuilderList = domainMapper.getCryptocurrencyBuilderList(symbolList: symbolList, cryptoList: cryptoList)
        let priceInfoResult = await apiDataSource.getPriceInfoForCryptos(id: cryptocurrenciesBuilderList.map { $0.id })
        
        guard case .success(let priceInfo) = priceInfoResult else {
            return .failure(errorMapper.map(error: priceInfoResult.failureError as? HTTPClientError))
        }
        
        return .success(domainMapper.map(builderList: cryptocurrenciesBuilderList, priceInfo: priceInfo))
    }
}
