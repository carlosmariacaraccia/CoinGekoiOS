//
//  HTTPClientError.swift
//  CoinGekoiOS
//
//  Created by Carlos Caraccia on 6/5/24.
//

import Foundation

enum HTTPClientError: Error {
    case clientError
    case serverError
    case generic
    case parsingError(Error)
    case invalidUrl
    case invalidResponse
    case invalidStatusCode
}
