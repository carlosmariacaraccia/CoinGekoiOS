//
//  Result+FailureError.swift
//  CoinGekoiOS
//
//  Created by Carlos Caraccia on 6/4/24.
//

import Foundation

extension Result {
    var failureError: Error? {
        switch self {
        case .failure(let error):
            return error
        default:
            return nil
        }
    }
}
