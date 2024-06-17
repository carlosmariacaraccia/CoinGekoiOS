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

class CryptoCurrencyDomainErrorMapper: ICryptoCurrencyDomainErrorMapper {
    func map(error: HTTPClientError?) -> CryptoCryptocurrencyDomainError {
        .generic
    }
}
