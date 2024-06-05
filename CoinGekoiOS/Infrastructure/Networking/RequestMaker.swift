//
//  RequestMaker.swift
//  CoinGekoiOS
//
//  Created by Carlos Caraccia on 6/5/24.
//

import Foundation

class RequestMaker {
    func url(endpoint: Endpoint, baseUrl: String) -> URL? {
        var components = URLComponents(string: baseUrl + endpoint.path)
        components?.queryItems = endpoint.queryParameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        return components?.url
    }
}
