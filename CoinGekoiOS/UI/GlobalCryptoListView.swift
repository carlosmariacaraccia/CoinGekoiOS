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
            List {
                ForEach(viewModel.cryptos) { crypto in
                    Text(crypto.name)
                }
            }
        }
        .onAppear(perform: viewModel.onAppear)
    }
}

//#Preview {
//    GlobalCryptoListView()
//}

