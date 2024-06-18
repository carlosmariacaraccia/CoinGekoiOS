//
//  GlobalCryptoListView.swift
//  CoinGekoiOS
//
//  Created by Carlos Caraccia on 6/17/24.
//

import SwiftUI

struct GlobalCryptoListView: View {
    @StateObject var viewModel: GlobalCryptoListViewModel

    var body: some View {
        VStack {
            if viewModel.showLoadingSpinner {
                ProgressView()
                    .progressViewStyle(.circular)
            } else {
                List {
                    ForEach(viewModel.cryptos) { crypto in
                        CryptoListItemView(item: crypto)
                    }
                }
            }
        }
        .onAppear(perform: viewModel.onAppear)
        .refreshable { viewModel.onAppear() }
        .alert("Error", isPresented: $viewModel.showErrorAlert, actions: errorActions, message: errorMessage)
    }

    private func errorActions() -> some View {
        Button("OK", action: {})
    }

    private func errorMessage() -> some View {
        Text(viewModel.showErrorMessage ?? "No message was added")
    }
}
