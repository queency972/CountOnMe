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

    var operators: [String] = ["+"]

    // Error check computed variables
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/"
    }

    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }

    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/"
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
            case "x":
                calculString.append(" x ")
            case "/":
                calculString.append(" / ")
            default:
                NotificationCenter.default.post(name: Notification.Name("error"), object: nil)
            }
        } else {
            NotificationCenter.default.post(name: Notification.Name("error"), object: nil)
        }
    }

    func orderOfOperations() {
        var operation = elements
        let priorityOperators = ["x", "/"]
        let calcOperators = ["+", "-"]

        var result: Double = 0
        while operation.count > 1 {
            let firstIndexOfpriorityOperator = operation.firstIndex(where: {priorityOperators.contains($0)})
            if let priorityOperatorIndex = firstIndexOfpriorityOperator {
                let calculOperator = operation[priorityOperatorIndex]
                let left = Double(operation[priorityOperatorIndex - 1])!
                let right = Double(operation[priorityOperatorIndex + 1])!
                switch calculOperator {
                case "x":
                    result = left * right
                case "/":
                    result = left / right
                default:
                    print("Error")
                }
                operation[priorityOperatorIndex] = "\(result)"
                operation.remove(at: priorityOperatorIndex + 1)
                operation.remove(at: priorityOperatorIndex - 1)
            }

            else {
                let firstIndexOfOperator = operation.firstIndex(where: {calcOperators.contains($0)})
                if let operatorIndex = firstIndexOfOperator {
                    let calculOperator = operation[operatorIndex]
                    let left = Double(operation[operatorIndex - 1])!
                    let right = Double(operation[operatorIndex + 1])!
                    switch calculOperator {
                    case "+":
                        result = left + right
                    case "-":
                        result = left - right
                    default:
                        print("Error")
                    }
                    operation[operatorIndex] = "\(result)"
                    operation.remove(at: operatorIndex + 1)
                    operation.remove(at: operatorIndex - 1)
                }
            }
        }
        calculString = calculString + " = \(operation[0])"
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
        orderOfOperations()
    }
}
