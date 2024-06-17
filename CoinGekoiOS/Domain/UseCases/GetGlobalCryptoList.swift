//
//  GetGlobalCryptoList.swift
//  CoinGekoiOS
//
//  Created by Carlos Caraccia on 5/28/24.
//

import Foundation

enum CryptoCryptocurrencyDomainError: Error {
    case generic
}

protocol IGetGlobalCryptoList {
    func execute() async -> Result<[Cryptocurrency], CryptoCryptocurrencyDomainError>
}

class GetGlobalCryptoList: IGetGlobalCryptoList {
    // as we only have 1 method and it will have the same name as the class
    // then we will call it execute
    private let repo: IRemoteCryptoCurrencyRepostiory
    
    init(repo: IRemoteCryptoCurrencyRepostiory) {
        self.repo = repo
    }
    
    func execute() async -> Result<[Cryptocurrency], CryptoCryptocurrencyDomainError> {
        let result = await repo.getGlobalCryptoList()
        guard let cryptoList = try? result.get() else { 
            if case let .failure(error) = result {
                return .failure(.generic)
            }
            return .failure(.generic) // we don't know what happened yet
        }
        return .success(cryptoList.sorted(by: { $0.marketCap > $1.marketCap }))
        
    }
}
