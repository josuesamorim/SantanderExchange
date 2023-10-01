//
//  RatesHistoricalDataProvider.swift
//  Santander Exchange
//
//  Created by Josué Amorim on 29/09/23.
//


import Foundation

protocol RatesHistoricalDataProviderDelegate: DataProviderManagerDelegate {
    func success(model: RatesHistoricalObject)
}


class RatesHistoricalDataProvider: DataProviderManager<RatesHistoricalDataProviderDelegate, RatesHistoricalObject>{
    
    private let ratesStore: RatesStore
    
    init(ratesStore: RatesStore = RatesStore()) {
        self.ratesStore = ratesStore
    }
    
    func fetchTimesseries(by base: String, from symbols: [String], startDate: String, endDate: String){
        Task.init {
            do {
                let model = try await ratesStore.fetchTimesseries(by: base, from: symbols, startDate: startDate, endDate: endDate)
                delegate?.success(model: model)
            } catch {
                delegate?.errorData(delegate, error: error)
            }
        }
    }
    
    
}
