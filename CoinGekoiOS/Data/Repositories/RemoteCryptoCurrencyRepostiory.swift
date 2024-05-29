//
//  RemoteCryptoCurrencyRepostiory.swift
//  CoinGekoiOS
//
//  Created by Carlos Caraccia on 5/28/24.
//

import Foundation

// En esta capa van a hacer muchos mas errores que de costumbre
// porque esta capa habla directamente con URLSession, pueden haber
// errores de parseo, del servidor, errores con el cliente, errores por
// demasiadas peticiones, etc

enum HTTPClientError: Error {
    case clientError
    case serverError
}

protocol IAPIDataSource {
    func getGlobalCryptoList() async -> Result<[String], HTTPClientError>
    func getCryptoList() async -> Result<[CryptocurrencyBasicDTO], HTTPClientError>
    func getPriceInfoForCryptos(id: [String]) async -> Result<[String: CryptoCurrencyPriceInfoDTO], HTTPClientError>
}

class CryptoCurrencyDomainErrorMapper {
    // we need to map from the of the request to the mapper
}

        
        

class RemoteCryptoCurrencyRepostiory: IGetGlobalCryptoListRemoteRepository {
    
    private let apiDataSource: IAPIDataSource
    
    init(apiDataSource: IAPIDataSource) {
        self.apiDataSource = apiDataSource
    }
    
    func getGlobalCryptoList() async -> Result<[Cryptocurrency], CryptoCryptocurrencyDomainError> {
        
        let symbolListResult = await apiDataSource.getGlobalCryptoList()
        let cryptoListResult = await apiDataSource.getCryptoList()
        
        if case let .failure(error) = symbolListResult {
            return .failure(.generic)
        }
        
        if case let .failure(error) = cryptoListResult {
            return .failure(.generic)
        }
        
        
        
        

        // first get the crypto list
        // get the price
        // get the market cap
        
        // the repo is already having a big responsibility, that's to orchestrate all the calls from the web
        fatalError()
    }
}
