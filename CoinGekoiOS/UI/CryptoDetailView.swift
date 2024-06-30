//
//  CryptoDetailView.swift
//  CoinGekoiOS
//
//  Created by Carlos Caraccia on 6/18/24.
//

import SwiftUI
import Charts

struct ChartDataPoint: Identifiable {
    let id = UUID()
    let date: Date
    let price: Double
}

struct CryptoDetailView: View {
    @StateObject var viewModel: CryptoDetailViewModel
    
    var body: some View {
        ZStack {
            VStack {
                CryptoDetailHeaderView(cryptocurrency: viewModel.cryptocurrency)
                Spacer()
                Chart(viewModel.dataPoints) { dataPoint in
                    LineMark(
                        x: .value("Fecha", dataPoint.date),
                        y: .value("Price", dataPoint.price)
                    )
                }
            }
            if viewModel.showLoadingSpinner {
                ProgressView()
                    .progressViewStyle(.circular)
            }
        }
        .onAppear(perform: viewModel.onAppear)
    }
}

//#Preview {
//    CryptoDetailView(viewModel: .init(getPriceHistory: any IGetPriceHistory))
//}

class CryptoDetailFactory: ICreateCryptoDetailView {
    
    func create(cryptocurrency: CryptocurrencyListPresentableItem) -> CryptoDetailView {
        CryptoDetailView(viewModel: self.createViewModel(cryptocurrency: cryptocurrency))
    }
    
    private func createViewModel(cryptocurrency: CryptocurrencyListPresentableItem) -> CryptoDetailViewModel {
        CryptoDetailViewModel(
            getPriceHistory: createUseCase(),
            errorMapper: CryptocurrencyPresentableErrorMapper(),
            cryptocurrency: cryptocurrency
        )
    }
    
    private func createUseCase() -> IGetPriceHistory {
        GetPriceHistory(cryptocurrencyPriceHistoryRepository: createPriceHistoryRepo())
    }
    
    private func createPriceHistoryRepo() -> IRemoteCryptocurrencyPriceHistoryRepository {
        RemoteCryptocurrencyPriceHistoryRepository(
            apiDataSource: createAPIPriceHistoryDataSource(),
            domainMapper: CryptocurrencyPriceHistoryDomainMapper(),
            errorMapper: CryptoCurrencyDomainErrorMapper()
        )
    }
    
    private func createAPIPriceHistoryDataSource() -> IAPIPriceHistoryDataSource {
        APIPriceHistoryDataSource(httpClient: createHTTPClient())
    }
    
    private func createHTTPClient() -> IHTTPClient {
        HTTPClient(session: URLSession.shared, requestMaker: RequestMaker())
    }
}
