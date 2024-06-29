//
//  CryptoDetailViewModel.swift
//  CoinGekoiOS
//
//  Created by Carlos Caraccia on 6/17/24.
//

import Foundation

class CryptoDetailViewModel: ObservableObject {
    @Published var dataPoints = [ChartDataPoint]()
    @Published var showLoadingSpinner = false
    @Published var showErrorMessage: String?
    
    private let getPriceHistory: IGetPriceHistory
    private let errorMapper: CryptocurrencyPresentableErrorMapper
    
    init(getPriceHistory: IGetPriceHistory, errorMapper: CryptocurrencyPresentableErrorMapper) {
        self.getPriceHistory = getPriceHistory
        self.errorMapper = errorMapper
    }
    
    @MainActor
    func onAppear() {
        showLoadingSpinner = true
        Task {
            let result = await getPriceHistory.execute(id: "bitcoin", days: 30)
            guard case .success(let priceHistory) = result else {
                handleError(error: result.failureError as? CryptocurrencyDomainError)
                return
            }
            showLoadingSpinner = false
            dataPoints = priceHistory.prices.map { ChartDataPoint(date: $0.date, price: $0.price) }
        }
    }
    
    private func handleError(error: CryptocurrencyDomainError?) {
        showLoadingSpinner = false
        showErrorMessage = errorMapper.map(domainError: error)
    }
}
