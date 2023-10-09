//
//  HistoricViewController.swift
//  Santander Exchange
//
//  Created by Josué Amorim on 08/10/23.
//

// Importe o UIKit
import UIKit

class HistoricViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    
    var historicData: [Conversion] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.dataSource = self
        loadHistoricData()
    }
    
    func updateTable() {
        table.reloadData()
    }
    

    func loadHistoricData() {
        historicData = ViewController.conversionsHistory
        updateTable()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historicData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let historicDt = historicData[indexPath.row]

        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.label.text = "\(historicDt.amount)  \(historicDt.fromCurrency) para \(historicDt.toCurrency) = \(historicDt.result) \(historicDt.toCurrency)"
        
        
        return cell
    }
}
