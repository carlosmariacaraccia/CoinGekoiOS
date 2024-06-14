//
//  GlobalCryptoListViewModel.swift
//  CoinGekoiOS
//
//  Created by Carlos Caraccia on 6/5/24.
//

import Foundation

class GlobalCryptoListViewModel {
    private let globalCryptoListRemoteRepository: IGlobalCryptoListRemoteRepository
    
    init(globalCryptoListRemoteRepository: IGlobalCryptoListRemoteRepository) {
        self.globalCryptoListRemoteRepository = globalCryptoListRemoteRepository
    }
    
    func onAppear() {
        Task {
            let result = await globalCryptoListRemoteRepository.getGlobalCryptoList()
        }
    }
}
