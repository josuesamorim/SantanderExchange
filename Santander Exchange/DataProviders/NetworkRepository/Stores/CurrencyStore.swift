//
//  CurrencyStore.swift
//  Santander Exchange
//
//  Created by Josué Amorim on 29/09/23.
//

import Foundation

protocol CurrencyStoreProtocol {
    func fetchSymbols() async throws -> CurrencySymbolObject
}

class CurrencyStore: BaseStore, CurrencyStoreProtocol {
    func fetchSymbols() async throws -> CurrencySymbolObject {
        
        guard let urlRequest = try CurrencyRouter.symbols.asUrlRequest() else {
            throw error
        }
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let symbols = try SymbolResult(data: data, response: response).symbols else {
            throw error
        }
        return symbols
    }
}
