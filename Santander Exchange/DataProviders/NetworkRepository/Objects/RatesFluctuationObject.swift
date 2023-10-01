//
//  RatesFluctuationObject.swift
//  Santander Exchange
//
//  Created by Josué Amorim on 28/09/23.
//

import Foundation


struct FlutuactionObject: Codable {
    let change: Double
    let changePct: Double
    let endRate: Double
    
    enum CodingKeys: String, CodingKey {
        case change
        case changePct = "change_pct"
        case endRate = "end_rate"
        
    }
}
