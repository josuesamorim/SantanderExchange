//
//  DataProviderManager.swift
//  Santander Exchange
//
//  Created by Josué Amorim on 29/09/23.
//

import Foundation

protocol DataProviderManagerDelegate {
    func success(model: Any)
    func errorData(_ provider: DataProviderManagerDelegate?, error: Error)
}

extension DataProviderManagerDelegate {
    
    func success(model: Any){
        preconditionFailure("This method must be overridden")
    }
    
    func errorData(_ provider: DataProviderManagerDelegate?, error: Error){
        print(error.localizedDescription)
    }
}

class DataProviderManager<T, S> {
    var delegate: T?
    var model: S?
}
