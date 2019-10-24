//
//  ViewController.swift
//  In-App Purchase
//
//  Created by Mohamed on 10/23/19.
//  Copyright © 2019 Mohamed74. All rights reserved.
//

import UIKit
import StoreKit

class TableViewController: UITableViewController,SKPaymentTransactionObserver{
  
    

    let appID = "Mohamed-osama.In-App-Purchase"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        for conuter in ModelData.getFreeQuotes(){
            
            print(conuter)
        }
        
    }
    
    //MARK:- IBActions
    
    @IBAction func restoreButtonPressed(_ sender: UIBarButtonItem) {
        
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        
        return ModelData.getFreeQuotes().count + 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellItem", for: indexPath)
        
        if indexPath.row < ModelData.getFreeQuotes().count{
            
            cell.textLabel?.text = ModelData.getFreeQuotes()[indexPath.row]
            
        }else {
            
            cell.textLabel?.text = "Get more quotes"
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        }
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == ModelData.getFreeQuotes().count{
            
            buyMoreQuotes()
        }
        
        
    }
    
    func buyMoreQuotes(){
        
        if SKPaymentQueue.canMakePayments(){
            
            let paymentRequest = SKMutablePayment()
            
            paymentRequest.productIdentifier = appID
            
            SKPaymentQueue.default().add(paymentRequest)
            
        }else{
            
            
            
        }
        
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
          
                
        for transaction in transactions {
            
            switch transaction.transactionState {
            case .purchased:
                
                // payment successfully
                
                print("payment successfully")
                showPriemumQuotes()
                SKPaymentQueue.default().finishTransaction(transaction)
                break
                
            case .failed:
                
                // payment failed
                print("payment failed")
                break
                
            case .restored:
                SKPaymentQueue.default().restoreCompletedTransactions()
                
                break
            default:
                break
            }
        }
        
      }
    
    
    
    func showPriemumQuotes(){
        
        var quotes = ModelData.getFreeQuotes()
        
        quotes.append(contentsOf: ModelData.getPriemuimQuotes())
        
        tableView.reloadData()
    }
    
}

