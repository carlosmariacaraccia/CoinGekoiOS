//
//  GlobalCryptoListViewModel.swift
//  CoinGekoiOS
//
//  Created by Carlos Caraccia on 6/5/24.
//

import Foundation
import SwiftUI

class GlobalCryptoListViewModel: ObservableObject {
    @Published var cryptos = [CryptocurrencyListPresentableItem]()
    @Published var showLoadingSpinner = false
    @Published var showErrorAlert = false

    var showErrorMessage: String?

    private let getGlobalCryptoList: IGetGlobalCryptoList
    private let errorMapper: CryptocurrencyPresentableErrorMapper
    
    init(getGlobalCryptoList: IGetGlobalCryptoList, errorMapper: CryptocurrencyPresentableErrorMapper) {
        self.getGlobalCryptoList = getGlobalCryptoList
        self.errorMapper = errorMapper
    }
    
    @MainActor
    func onAppear() {
        showLoadingSpinner = true
        Task {
            do {
                self.cryptos = try await getGlobalCryptoList.execute().get().map(CryptocurrencyListPresentableItem.init)
            } catch {
                self.showErrorAlert = true
                handleError(error: error as? CryptocurrencyDomainError)
            }
            showLoadingSpinner = false
        }
    }
    
    private func handleError(error: CryptocurrencyDomainError?) {
        showErrorMessage = errorMapper.map(domainError: error)
    }
}

// MARK: - Double extension to convert to String and return a two decimal place formatted String
extension Double {
    func twoDecimalPlacesFormatted() -> String {
        self.formatted(.number.precision(.fractionLength(2)))
    }
}
