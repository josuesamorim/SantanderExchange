//
//  ViewController.swift
//  Santander Exchange
//
//  Created by Josué Amorim on 28/09/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var picker1: UIPickerView!
    @IBOutlet weak var picker2: UIPickerView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var headerDateLabel: UILabel!
    
    var currentSymbolsArray: [String] = []
    var rate: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker1.delegate = self
        picker1.dataSource = self
        
        picker2.delegate = self
        picker2.dataSource = self
        
        textField.delegate = self
               
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        Task {
            var dateInPortuguese = actualDateInPortuguese()
            headerDateLabel.text = dateInPortuguese
            await getSymbolData()
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func converterButton(_ sender: UIButton) {
        let selectedRow1 = picker1.selectedRow(inComponent: 0)
        let selectedRow2 = picker2.selectedRow(inComponent: 0)
        
        let selectValue1 = currentSymbolsArray[selectedRow1]
        let selectValue2 = currentSymbolsArray[selectedRow2]
        
        
        doFetchData(firstCurrency: selectValue1, secondCurrency: selectValue2)
        let result = calcConvertion()
        let formattedResult = formatDoubleToTwoDecimalPlaces(result)
        resultLabel.text = "\(formattedResult) \(selectValue2)"
    }
    
    private func doFetchData(firstCurrency: String, secondCurrency: String) {
        let rateHistoricalDataProvider = RatesHistoricalDataProvider()
        rateHistoricalDataProvider.delegate = self
        let date = formattedDate()
        rateHistoricalDataProvider.fetchTimesseries(by: "\(firstCurrency)", from: ["\(secondCurrency)"], startDate: date, endDate: date)
    }
    
    private func getSymbolData() async {
        let currencyStore = CurrencyStore()
        
        do {
            let meuArray = try await currencyStore.fetchSymbols()
            
            for (key, _) in meuArray {
                currentSymbolsArray.append(key)
            }
            
            picker1.reloadAllComponents()
            picker2.reloadAllComponents()
            
        } catch {
            print("Erro ao buscar os símbolos. Retornando um dicionário vazio.")
        }
    }
    
    private func calcConvertion() -> Double {
        guard let textFieldInput = Double(textField.text ?? "") else {
            return 0.0
        }
        return rate * textFieldInput
    }
    
    private func formattedDate() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: currentDate)
    }
    
    func actualDateInPortuguese() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.setLocalizedDateFormatFromTemplate("dd MMMM yyyy")
        
        let ActualDate = Date()
        let dataFormatada = dateFormatter.string(from: ActualDate)
        
        return dataFormatada
    }

    
    private func formatDoubleToTwoDecimalPlaces(_ number: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        
        if let formattedString = numberFormatter.string(from: NSNumber(value: number)) {
            return formattedString
        } else {
            return "Erro ao formatar"
        }
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    // Implementação da extensão para o UIPickerViewDelegate e UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // Número de componentes (colunas) no UIPickerView
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currentSymbolsArray.count // Número de linhas no UIPickerView
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currentSymbolsArray[row] // Título para cada linha
    }

}

extension ViewController: UITextFieldDelegate {
    // Implementação da extensão para o UITextFieldDelegate
    // MARK: - TextField
               
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension ViewController: RatesHistoricalDataProviderDelegate {
    func success(model: RatesHistoricalObject) {
        let currencyRates = model
        let date = formattedDate()
        
        if let innerDictionary = currencyRates[date], let rate = innerDictionary.values.first {
            self.rate = rate
        } else {
            print("A chave externa ou interna não foi encontrada no dicionário.")
        }
    }
}
