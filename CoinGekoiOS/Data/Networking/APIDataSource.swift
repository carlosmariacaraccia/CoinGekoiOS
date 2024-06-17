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
    func getPriceInfoForCryptos(id: [String]) async -> Result<[String: CryptoCurrencyPriceInfoDTO?], HTTPClientError>
}

class APIDataSource: IAPIDataSource {
    
    private let httpClient: IHTTPClient
    
    init(httpClient: IHTTPClient) {
        self.httpClient = httpClient
    }
    
    func getGlobalCryptoList() async -> Result<[String], HTTPClientError> {
        let endpoint = Endpoint(path: "global", method: .get, queryParameters: [:])
        let result = await httpClient.makeRequest(endpoint: endpoint, baseUrl: "https://api.coingecko.com/api/v3/")
        
        guard case .success(let data) = result else {
            guard case .failure(let error) = result else {
                return .failure(.generic)
            }
            return .failure(error)
        }
        
        do {
            let symbolList = try JSONDecoder().decode(CryptocurrecyGlobalInfoDTO.self, from: data)
            return .success(Array(symbolList.data.cryptocurrencies.keys))
        } catch {
            return .failure(.parsingError(error))
        }
    }
    
    func getCryptoList() async -> Result<[CryptocurrencyBasicDTO], HTTPClientError> {
        let endpoint = Endpoint(path: "coins/list", method: .get, queryParameters: [:])
        let result = await httpClient.makeRequest(endpoint: endpoint, baseUrl: "https://api.coingecko.com/api/v3/")

        guard case .success(let data) = result else {
            guard case .failure(let error) = result else {
                return .failure(.generic)
            }
            return .failure(error)
        }
        
        do {
            let cryptoList = try JSONDecoder().decode([CryptocurrencyBasicDTO].self, from: data)
            return .success(cryptoList)
        } catch {
            return .failure(.parsingError(error))
        }
    }
    
    func getPriceInfoForCryptos(id: [String]) async -> Result<[String : CryptoCurrencyPriceInfoDTO?], HTTPClientError> {
        let queryParams: [String: Any] = [
            "ids": id.joined(separator: ","),
            "vs_currencies": "usd",
            "include_market_cap": true,
            "include_24hr_vol": true,
            "include_24hr_change": true
        ]
        let endpoint = Endpoint(path: "simple/price", method: .get, queryParameters: queryParams)
        let result = await httpClient.makeRequest(endpoint: endpoint, baseUrl: "https://api.coingecko.com/api/v3/")

        guard case .success(let data) = result else {
            guard case .failure(let error) = result else {
                return .failure(.generic)
            }
            return .failure(error)
        }
        
        do {
            let priceInfoForCryptos = try JSONDecoder().decode([String : CryptoCurrencyPriceInfoDTO].self, from: data)
            return .success(priceInfoForCryptos)
        } catch {
            return .failure(.parsingError(error))
        }
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
