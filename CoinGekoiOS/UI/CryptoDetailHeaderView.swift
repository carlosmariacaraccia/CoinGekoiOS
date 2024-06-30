//
//  CryptoDetailHeaderView.swift
//  CoinGekoiOS
//
//  Created by Carlos Caraccia on 6/18/24.
//

import SwiftUI
import Charts

struct CryptoDetailHeaderView: View {
   
    private let cryptocurrency: CryptocurrencyListPresentableItem
    
    init(cryptocurrency: CryptocurrencyListPresentableItem) {
        self.cryptocurrency = cryptocurrency
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(cryptocurrency.name)
                    .font(.title)
                Text(cryptocurrency.symbol)
                    .font(.title)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text(cryptocurrency.price)
                    .font(.title)
                Text(cryptocurrency.price24h)
                    .font(.headline)
            }
        }
        .padding()
        HStack {
            Text("Cap de mercado:")
                .font(.headline)
            Spacer()
            Text(cryptocurrency.marketCap)
                .font(.headline)
        }
        .padding(.horizontal)
        HStack {
            Text("Volumen en 24h: ")
                .font(.headline)
            Spacer()
            Text(cryptocurrency.volume24h)
                .font(.headline)
        }
        .padding(.horizontal)
    }
}

#Preview {
    CryptoDetailHeaderView(cryptocurrency: .init(domainModel: .mockedData))
}
