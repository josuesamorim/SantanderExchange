//
//  RatesRouter.swift
//  Santander Exchange
//
//  Created by Josué Amorim on 28/09/23.
//

import Foundation

enum RatesRouter {
    
    case fluctuation(base: String, symbols: [String], startDate: String, endDate: String)
    case timeseries(base: String, symbols: [String], startDate: String, endDate: String)
    
    
    var path: String {
        switch self {
        case.fluctuation: return RatesApi.fluctuation
        case.timeseries: return RatesApi.timeseries
        }
    }
    
    func asUrlRequest() throws -> URLRequest? {
         guard var urlComponents = URLComponents(string: RatesApi.baseUrl) else { return nil }
         
         switch self {
         case .fluctuation(let base, let symbols, let startDate, let endDate),
              .timeseries(let base, let symbols, let startDate, let endDate):
             
             var queryItems = [
                 URLQueryItem(name: "base", value: base),
                 URLQueryItem(name: "symbols", value: symbols.joined(separator: ",")),
                 URLQueryItem(name: "start_date", value: startDate),
                 URLQueryItem(name: "end_date", value: endDate)
             ]
             
             queryItems.append(URLQueryItem(name: "apikey", value: RatesApi.apiKey))
             
             urlComponents.queryItems = queryItems
         }
         
         guard let url = urlComponents.url else { return nil }
         
         var request = URLRequest(url: url.appendingPathComponent(path), timeoutInterval: Double.infinity)
         
         request.httpMethod = HttpMethod.get.rawValue
         // Add your API key to the request headers if needed
         request.addValue(RatesApi.apiKey, forHTTPHeaderField: "apikey")
         
         return request
     }
}
