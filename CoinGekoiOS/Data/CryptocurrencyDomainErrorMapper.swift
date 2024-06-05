//
//  CryptocurrencyDomainErrorMapper.swift
//  CoinGekoiOS
//
//  Created by Carlos Caraccia on 6/4/24.
//

import Foundation

protocol ICryptoCurrencyDomainErrorMapper {
    func map(error: HTTPClientError?) -> CryptoCryptocurrencyDomainError
}

class CryptoCurrencyDomainErrorMapper {
    func map(error: HTTPClientError?) -> CryptoCryptocurrencyDomainError {
        fatalError() // TODO: Implement a correct error logic conversion in this case
    }
}
