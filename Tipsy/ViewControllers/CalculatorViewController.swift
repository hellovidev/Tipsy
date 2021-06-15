//
//  ViewController.swift
//  Tipsy
//
//  Created by Sergey Romanchuk on 14.06.21.
//

import UIKit

class CalculatorViewController: UIViewController {
    @IBOutlet weak var totalBillTextField: UITextField!
    @IBOutlet weak var zeroTipButton: UIButton!
    @IBOutlet weak var tenTipButton: UIButton!
    @IBOutlet weak var twentyTipButton: UIButton!
    @IBOutlet weak var splitAmountLabel: UILabel!
    
    private var tip: Float = 0.1
    private var split: Int = 2
    private var bill: Float?
    private var result: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tipChanged(_ sender: UIButton) {
        //Deselect all tip buttons via IBOutlets
        zeroTipButton.isSelected = false
        tenTipButton.isSelected = false
        twentyTipButton.isSelected = false
        
        //Make the button that triggered the IBAction selected.
        sender.isSelected = true
        
        //Get the current title of the button that was pressed.
        let buttonTitle = sender.currentTitle!
        
        //Remove the last character (%) from the title then turn it back into a String.
        let buttonTitleMinusPercentSign =  String(buttonTitle.dropLast())
        
        //Turn the String into a Double.
        let buttonTitleAsANumber = Double(buttonTitleMinusPercentSign)!
        
        //Divide the percent expressed out of 100 into a decimal e.g. 10 becomes 0.1
        tip = Float(buttonTitleAsANumber / 100)
        
        totalBillTextField.endEditing(true)
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        split = Int(sender.value)
        splitAmountLabel.text = String(split)
    }
    
    @IBAction func calculateClicked(_ sender: UIButton) {
        checkValue()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.result = "\(result)"
            destinationVC.numberOfPeople = split
            destinationVC.tip = "\(Int(tip * 100))%"
        }
    }
    
    private func calculateSplitBill(bill: Float, tip: Float, split: Int) -> Float {
        return (bill - (bill * tip)) / Float(split)
    }
    
    private func checkValue() {
        if let text = totalBillTextField.text {
            if !text.isEmpty {
                bill = text.floatValue
                result = calculateSplitBill(bill: bill ?? 0.0, tip: tip, split: split)
                self.performSegue(withIdentifier: "goToResult", sender: self)
            } else {
                showWarningAlert()
            }
        }
    }
    
    private func showWarningAlert() {
        let alert = UIAlertController(title: "Field is empty!", message: "Please input total bill value.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }
}
