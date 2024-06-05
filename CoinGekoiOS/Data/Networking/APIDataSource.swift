//
//  APIDataSource.swift
//  CoinGekoiOS
//
//  Created by Carlos Caraccia on 6/5/24.
//

import Foundation

protocol IAPIDataSource {
    func getGlobalCryptoList() async -> Result<[String], HTTPClientError>
    func getCryptoList() async -> Result<[CryptocurrencyBasicDTO], HTTPClientError>
    func getPriceInfoForCryptos(id: [String]) async -> Result<[String: CryptoCurrencyPriceInfoDTO], HTTPClientError>
}

class APIDataSource: IAPIDataSource {
    
    private let httpClient: IHTTPClient
    
    init(httpClient: IHTTPClient) {
        self.httpClient = httpClient
    }
    
    func getGlobalCryptoList() async -> Result<[String], HTTPClientError> {
        let endpoint = Endpoint(path: "global", method: .get, queryParameters: [:])
        let result = await httpClient.makeRequest(endpoint: endpoint, baseUrl: "https://api.coingeko.com/api/v3/")
        
        guard case .success(let data) = result else {
            guard case .failure(let error) = result else {
                return .failure(.generic)
            }
            return .failure(error)
        }
        
        guard let symbolList = try? JSONDecoder().decode(CryptocurrecyGlobalInfoDTO.self, from: data) else {
            return .failure(.parsingError)
        }
        return .success(Array(symbolList.data.cryptocurrencies.keys))
    }
    
    func getCryptoList() async -> Result<[CryptocurrencyBasicDTO], HTTPClientError> {
        let endpoint = Endpoint(path: "coins/list", method: .get, queryParameters: [:])
        let result = await httpClient.makeRequest(endpoint: endpoint, baseUrl: "https://api.coingeko.com/api/v3/")

        guard case .success(let data) = result else {
            guard case .failure(let error) = result else {
                return .failure(.generic)
            }
            return .failure(error)
        }
        
        guard let cryptoList = try? JSONDecoder().decode([CryptocurrencyBasicDTO].self, from: data) else {
            return .failure(.parsingError)
        }
        return .success(cryptoList)
    }
    
    func getPriceInfoForCryptos(id: [String]) async -> Result<[String : CryptoCurrencyPriceInfoDTO], HTTPClientError> {
        let queryParams: [String: Any] = ["ids": id, "vs_currencies": "usd", "include_marke_cap": true, "include_24hr_vol": true, "include_24hr_change": true]
        let endpoint = Endpoint(path: "simple/price", method: .get, queryParameters: queryParams)
        let result = await httpClient.makeRequest(endpoint: endpoint, baseUrl: "https://api.coingeko.com/api/v3/")

        guard case .success(let data) = result else {
            guard case .failure(let error) = result else {
                return .failure(.generic)
            }
            return .failure(error)
        }
        
        guard let priceInfoForCryptos = try? JSONDecoder().decode([String : CryptoCurrencyPriceInfoDTO].self, from: data) else {
            return .failure(.parsingError)
        }
        return .success(priceInfoForCryptos)
    }
    
    private func handleError(error: HTTPClientError?) -> HTTPClientError {
        guard let error else {
            return HTTPClientError.generic
        }
        return error
    }
}

struct Endpoint {
    let path: String
    let method: HTTPMethod
    let queryParameters: [String: Any]
}

enum HTTPMethod {
    case get
    case post
}
