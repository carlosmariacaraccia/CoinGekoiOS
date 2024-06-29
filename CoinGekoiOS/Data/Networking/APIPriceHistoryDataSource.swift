//
//  APIPriceHistoryDataSource.swift
//  CoinGekoiOS
//
//  Created by Carlos Caraccia on 6/17/24.
//

import Foundation

protocol IAPIPriceHistoryDataSource {
    func getPriceHistory(id: String, days: Int) async -> Result<CryptocurrencyPriceHistoryDTO, HTTPClientError>
}

class APIPriceHistoryDataSource: IAPIPriceHistoryDataSource {
    
    private let httpClient: IHTTPClient
    
    init(httpClient: IHTTPClient) {
        self.httpClient = httpClient
    }
    
    func getPriceHistory(id: String, days: Int) async -> Result<CryptocurrencyPriceHistoryDTO, HTTPClientError> {
        let queryParams: [String: Any] = [
            "vs_currency": "usd",
            "days": days,
            "interval": "daily"
        ]
        
        let endpoint = Endpoint(
            path: "coins/\(id)/market_chart",
            method: .get,
            queryParameters: queryParams
        )
        
        let result = await httpClient.makeRequest(endpoint: endpoint, baseUrl: "http://api.coingecko.com/api/v3/")
        guard case .success(let data) = result else {
            return .failure(handleError(error: result.failureError as? HTTPClientError) )
        }
        
        do {
            let priceHistory = try JSONDecoder().decode(CryptocurrencyPriceHistoryDTO.self, from: data)
            return .success(priceHistory)
        } catch {
            return .failure(HTTPClientError.parsingError(error))
        }

    }
    
    func handleError(error: HTTPClientError?) -> HTTPClientError {
        guard let error = error else { return .generic }
        return error
    }
    
}
