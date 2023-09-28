//
//  RatesApi.swift
//  Santander Exchange
//
//  Created by Josué Amorim on 28/09/23.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
}

struct RatesApi {
    
    static let baseUrl = "https://api.apilayer.com/exchangerates_data"
    static let apiKey = "zKuED8T6KUH9NRGk9DHHPWAONaIp2EAX"
    static let symbols = "/symbols"
    static let fluctuation = "/fluctuation"
    static let timeseries = "/timeseries"
    
}
