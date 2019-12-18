//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Modified by Steve Bernard on 1/12/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!

    var calculator = Calculator()

    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = "0"
        NotificationCenter.default.addObserver(self, selector: #selector(updateScreen), name: Notification.Name("updateScreen"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(errorManager), name: Notification.Name("error"), object: nil)
    }

    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        calculator.add(number: numberText)
    }

    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        calculator.add(operation: "+")
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        calculator.add(operation: "-")
    }

    
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        calculator.add(operation: "x")
    }
    

    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        calculator.add(operation: "/")
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        calculator.calculate()
    }

    @objc func updateScreen() {
        textView.text = calculator.calculString
    }

    @objc func errorManager(notification: NSNotification) {
        let message = notification.userInfo!["message"]
        sendAlert(message: message as! String)
    }

    private func sendAlert(message: String) {
        let alertVC = UIAlertController(title: "Zéro!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}

