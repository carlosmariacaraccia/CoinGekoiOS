//
//  HTTPClientError.swift
//  CoinGekoiOS
//
//  Created by Carlos Caraccia on 6/5/24.
//

import Foundation

enum HTTPClientError: LocalizedError {
    case clientError
    case serverError
    case generic
    case parsingError(Error)
    case invalidUrl
    case invalidResponse
    case invalidStatusCode
    case tooManyRequests
    case underlyingError(Error)
}

extension HTTPClientError: Equatable {
    static func == (lhs: HTTPClientError, rhs: HTTPClientError) -> Bool {
        switch (lhs, rhs) {
        case (let .parsingError(lhsError), let .parsingError(rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return lhs.localizedDescription == rhs.localizedDescription
        }
    }

}
