//
//  HTTPClient.swift
//  CoinGekoiOS
//
//  Created by Carlos Caraccia on 6/5/24.
//

import Foundation

protocol IHTTPClient {
    func makeRequest(endpoint: Endpoint, baseUrl: String) async -> Result<Data, HTTPClientError>
}

class HTTPClient: IHTTPClient {
    private let session: URLSession
    private let requestMaker: RequestMaker
    
    init(session: URLSession, requestMaker: RequestMaker) {
        self.session = session
        self.requestMaker = requestMaker
    }
    
    func makeRequest(endpoint: Endpoint, baseUrl: String) async -> Result<Data, HTTPClientError> {
        print("made request")
        guard let url = requestMaker.url(endpoint: endpoint, baseUrl: baseUrl) else { return .failure(.invalidUrl) }
        do {
            let (data, response) = try await session.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse else { return .failure(.invalidResponse)}
            guard httpResponse.statusCode == 429 else { return .failure(.tooManyRequests) }
            guard 200..<300 ~= httpResponse.statusCode else { return .failure(.invalidStatusCode) }
            return .success(data)
        } catch {
            return .failure(.underlyingError(error)) // we need to add an underlyting error type
        }
    }
}
