//
//  CryptoListItemView.swift
//  CoinGekoiOS
//
//  Created by Carlos Caraccia on 6/17/24.
//

import SwiftUI

struct CryptoListItemView: View {
    let item: CryptocurrencyListPresentableItem
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.title3)
                        .lineLimit(1)
                    Text(item.symbol)
                        .font(.headline)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text(item.price)
                        .font(.title3)
                        .lineLimit(1)
                    Text(item.price24h)
                        .font(.headline)
                        .foregroundStyle(item.isPriceChangePositive ? .green : .red)
                }
            }
            HStack {
                VStack(alignment: .leading) {
                    Text("Maket Cap")
                        .font(.callout)
                        .lineLimit(1)
                    Text("24 h")
                        .font(.callout)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text(item.marketCap)
                        .font(.callout)
                        .lineLimit(1)
                    Text(item.volume24h)
                        .font(.callout)
                        .foregroundStyle(item.isPriceChangePositive ? .green : .red)
                }
            }
        }
    }
}

#Preview {
    CryptoListItemView(item: .init(domainModel: .mockedData))
}
