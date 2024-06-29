//
//  CryptoDetailHeaderView.swift
//  CoinGekoiOS
//
//  Created by Carlos Caraccia on 6/18/24.
//

import SwiftUI
import Charts

struct CryptoDetailHeaderView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Bitcoin")
                    .font(.title)
                Text("BTC")
                    .font(.title)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("23.9345")
                    .font(.title)
                Text("1.45%")
                    .font(.headline)
            }
        }
        .padding()
        HStack {
            Text("Cap de mercado:")
                .font(.headline)
            Spacer()
            Text("121212121212")
                .font(.headline)
        }
        .padding(.horizontal)
        HStack {
            Text("Volumen en 24h: ")
                .font(.headline)
            Spacer()
            Text("12123123")
                .font(.headline)
        }
        .padding(.horizontal)
    }
}

#Preview {
    CryptoDetailHeaderView()
}
