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
    
    // Instance of Calculator Class
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
    // Setup Action Button +
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        calculator.add(operation: "+")
    }
    
    // Setup Action Button -
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        calculator.add(operation: "-")
    }
    
    // Setup Action Button x
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        calculator.add(operation: "x")
    }
    
    // Setup Action Button /
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        calculator.add(operation: "/")
    }
    
    // Setup Button =
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        if calculator.expressionHaveResult {
            didPressAC()
        } else {
        calculator.calculate()
        }
    }

    // Setup Button AC
    @IBAction func tappedACButton(_ sender: UIButton) {
        didPressAC()
    }

    // Function Button AC
    func didPressAC() {
        calculator.calculString = ""
    }

    // Setup Button Point
    @IBAction func tappedPointButton(_ sender: UIButton) {
        calculator.addPoint()
    }
    
    // Function allows to update Screen via NotificationCenter.default.addObserver
    @objc func updateScreen() {
        textView.text = calculator.calculString
    }
    
    // Function allows to error manage via NotificationCenter.default.addObserver
    @objc func errorManager(notification: NSNotification) {
        var message = "An error occured"
        if let userInfo = notification.userInfo {
            if let messageString = userInfo["message"] as? String {
                message = messageString
            }
        }
        sendAlert(message: message)
    }

    // Function Alert allows to send UIAlertController
    private func sendAlert(message: String) {
        let alertVC = UIAlertController(title: "Oups!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}

