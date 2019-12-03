//
//  Calculatrice.swift
//  CountOnMe
//
//  Created by Steve Bernard on 30/11/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation

//protocol CalcDelegate: AnyObject {
//  func showAlert(_ alert: UIAlertController)
//}

class Calculator  {

    var calculString = "1 + 1 = 2" {
        didSet {
            NotificationCenter.default.post(name: Notification.Name("updateScreen"), object: nil)
        }
    }

    var elements: [String] {
        return calculString.split(separator: " ").map { "\($0)" }
    }

    // Error check computed variables
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-"
    }

    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }

    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-"
    }

    var expressionHaveResult: Bool {
        return calculString.firstIndex(of: "=") != nil
    }

    func add(number: String) {
        if expressionHaveResult {
            calculString = ""
        }
        calculString.append(number)
    }

    func add(operation: String) {
        if canAddOperator {
            switch operation {
            case "+":
                calculString.append(" + ")
            case "-":
                calculString.append(" - ")
            default:
                NotificationCenter.default.post(name: Notification.Name("error"), object: nil)
            }
        } else {
            NotificationCenter.default.post(name: Notification.Name("error"), object: nil)
        }
    }

    func calculate() {
        guard expressionIsCorrect else {
            NotificationCenter.default.post(name: Notification.Name("error"), object: nil)
            return
        }
        guard expressionHaveEnoughElement else {
            NotificationCenter.default.post(name: Notification.Name("error"), object: nil)
            return
        }

        // Create local copy of operations
        var operationsToReduce = elements

        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let left = Int(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Int(operationsToReduce[2])!

            let result: Int
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            default: fatalError("Unknown operator !")
            }

            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        calculString.append(" = \(operationsToReduce.first!)")
    }
}
