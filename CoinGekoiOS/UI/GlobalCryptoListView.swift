//
//  GlobalCryptoListView.swift
//  CoinGekoiOS
//
//  Created by Carlos Caraccia on 6/17/24.
//

import SwiftUI

protocol ICreateCryptoDetailView {
    func create() -> CryptoDetailView
}

struct GlobalCryptoListView: View {
    @ObservedObject private var viewModel: GlobalCryptoListViewModel
    private let createCryptoDetailView: ICreateCryptoDetailView
    
    init(viewModel: GlobalCryptoListViewModel, createCryptoDetailView: ICreateCryptoDetailView) {
        self.viewModel = viewModel
        self.createCryptoDetailView = createCryptoDetailView
    }

    var body: some View {
        VStack {
            if viewModel.showLoadingSpinner {
                ProgressView()
                    .progressViewStyle(.circular)
            } else {
                NavigationStack {
                    List {
                        ForEach(viewModel.cryptos) { crypto in
                            NavigationLink {
                                createCryptoDetailView.create()
                            } label: {
                                CryptoListItemView(item: crypto)
                            }
                        }
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
