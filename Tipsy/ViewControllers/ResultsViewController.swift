//
//  ResultsViewController.swift
//  Tipsy
//
//  Created by Sergey Romanchuk on 14.06.21.
//

import UIKit

class ResultsViewController: UIViewController {
    
    var result: String = ""
    var numberOfPeople: Int = 0
    var tip: String = "0%"

    @IBOutlet weak var resultBill: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultBill.text = result
        descriptionLabel.text = "Split between \(numberOfPeople) people, with \(tip) tip."

        // Do any additional setup after loading the view.
    }
    
    @IBAction func recalculateAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
