//
//  CryptoDetailViewModel.swift
//  CoinGekoiOS
//
//  Created by Carlos Caraccia on 6/17/24.
//

import Foundation

struct ChartDataPoint: Identifiable {
    let id = UUID()
    let date: Date
    let price: Double
}

enum DaysOption: String, CaseIterable {
    case month = "30d"
    case ninety = "90d"
    case hundredAndEighty = "180d"
    case year = "1a"
    
    func toInt() -> Int {
        switch self {
        case .month:
            return 30
        case .ninety:
            return 90
        case .hundredAndEighty:
            return 180
        case .year:
            return 365
        }
    }
}

class CryptoDetailViewModel: ObservableObject {
    @Published var dataPoints = [ChartDataPoint]()
    @Published var showLoadingSpinner = false
    @Published var showErrorMessage: String?
    
    private let getPriceHistory: IGetPriceHistory
    private let errorMapper: CryptocurrencyPresentableErrorMapper
    let cryptocurrency: CryptocurrencyListPresentableItem
    
    init(
        getPriceHistory: IGetPriceHistory,
        errorMapper: CryptocurrencyPresentableErrorMapper,
        cryptocurrency: CryptocurrencyListPresentableItem
    ) {
        self.getPriceHistory = getPriceHistory
        self.errorMapper = errorMapper
        self.cryptocurrency = cryptocurrency
    }
    
    @MainActor
    func onAppear() {
        getPriceHistory(daysOption: .month)
    }
    
    @MainActor
    func getPriceHistory(daysOption: DaysOption) {
        showLoadingSpinner = true
        Task {
            let result = await getPriceHistory.execute(id: cryptocurrency.id, days: daysOption.toInt())
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
