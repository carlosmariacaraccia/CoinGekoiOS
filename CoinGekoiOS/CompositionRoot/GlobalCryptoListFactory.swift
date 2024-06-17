//
//  GlobalCryptoListFactory.swift
//  CoinGekoiOS
//
//  Created by Carlos Caraccia on 6/17/24.
//

import Foundation

class GlobalCryptoListFactory {
    
    static func createUseCase() -> IGetGlobalCryptoList {
        GetGlobalCryptoList(repo: createRemoteCryptoCurrencyRepository())
    }
    
    private static func createRemoteCryptoCurrencyRepository() -> IRemoteCryptoCurrencyRepostiory {
        RemoteCryptoCurrencyRepostiory(
            apiDataSource: createAPIDataSource(),
            errorMapper: CryptoCurrencyDomainErrorMapper(),
            domainMapper: CryptocurrencyDomainMapper()
        )
    }
    
    private static func createAPIDataSource() -> IAPIDataSource {
        let httpClient = HTTPClient(session: URLSession.shared, requestMaker: RequestMaker())
        return APIDataSource(httpClient: httpClient)
    }
}
