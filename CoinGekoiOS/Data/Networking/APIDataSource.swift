//
//  APIDataSource.swift
//  CoinGekoiOS
//
//  Created by Carlos Caraccia on 6/5/24.
//

import Foundation

protocol IHTTPClient {
    func makeRequest(endpoint: String) -> Result<Data, HTTPClientError>
}

protocol IAPIDataSource {
    func getGlobalCryptoList() async -> Result<[String], HTTPClientError>
    func getCryptoList() async -> Result<[CryptocurrencyBasicDTO], HTTPClientError>
    func getPriceInfoForCryptos(id: [String]) async -> Result<[String: CryptoCurrencyPriceInfoDTO], HTTPClientError>
}

class APIDataSource: IAPIDataSource {
    
    private let httpClient: IHTTPClient
    
    
    func getGlobalCryptoList() async -> Result<[String], HTTPClientError> {
        let endpoint = ""
    }
    
    func getCryptoList() async -> Result<[CryptocurrencyBasicDTO], HTTPClientError> {
        <#code#>
    }
    
    func getPriceInfoForCryptos(id: [String]) async -> Result<[String : CryptoCurrencyPriceInfoDTO], HTTPClientError> {
        <#code#>
    }
    
    
}
