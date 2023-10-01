//
//  ViewController.swift
//  Santander Exchange
//
//  Created by Josué Amorim on 28/09/23.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var buttonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func button(_ sender: UIButton) {
        doFetchData()
    }
    
    
    private func doFetchData(){
        let rateFluctuationDataProvider = RatesFluctuationDataProvider()
        rateFluctuationDataProvider.delegate = self
        rateFluctuationDataProvider.fetchFluctuation(by: "BRL", from: ["USD", "BRL"], startDate: "2022-10-11", endDate: "2022-11-11")
        
        let rateSymbolDataProvider = CurrencySymbolsDataProvider()
        rateSymbolDataProvider.delegate = self
        rateSymbolDataProvider.fetchSymbols()
        
        let rateHistoricalDataProvider = RatesHistoricalDataProvider()
        rateHistoricalDataProvider.delegate = self
        rateHistoricalDataProvider.fetchTimesseries(by: "USD", from: ["BRL"], startDate: "2023-10-01", endDate: "2023-10-01")
    }

}

extension ViewController: RatesFluctuationDataProviderDelegate {
    func success(model: RatesFluctuationObject) {
        print("AAA rateFluctuationModel: \(model)\n\n")
    }
}

extension ViewController: CurrencySymbolsDataProviderDelegate {
    func success(model: CurrencySymbolObject) {
        print("BBB CurrencySymbolModel: \(model)\n\n")
    }
}

extension ViewController: RatesHistoricalDataProviderDelegate {
    func success(model: RatesHistoricalObject) {
        print("CCC RatesHistoricalModel: \(model)\n\n")
    }
}




