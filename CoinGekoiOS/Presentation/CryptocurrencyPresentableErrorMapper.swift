//
//  CryptocurrencyPresentableErrorMapper.swift
//  CoinGekoiOS
//
//  Created by Carlos Caraccia on 6/17/24.
//

import Foundation

class CryptocurrencyPresentableErrorMapper {
    func map(domainError: CryptoCryptocurrencyDomainError?) -> String {
        guard let error = domainError else { return "Something went wrong" }
        switch error {
        case .generic:
            return "a generic error has occurred"
        case .tooManyRequests:
            return "Requests Rate Limit, please wait 1 min before continuing"
        }
    }
}
