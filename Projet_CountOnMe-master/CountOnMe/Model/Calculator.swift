//
//  Calculatrice.swift
//  CountOnMe
//
//  Created by Steve Bernard on 30/11/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculator  {

    // Variable allows to display String in viewLabal with a NotificationCenter.default.post
    var calculString = "" {
        didSet {
            NotificationCenter.default.post(name: Notification.Name("updateScreen"), object: nil)
        }
    }

    // Calculated property
    var elements: [String] {
        return calculString.split(separator: " ").map { "\($0)" }
    }

    // Return bool to check if expression is correct
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/"
    }

    // Return bool to check if expression has enough elements to make calcul
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }

    // Return bool to check if we can add an operator
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/"
    }

    // Return expression which has a result and different of nil
    var expressionHaveResult: Bool {
        return calculString.firstIndex(of: "=") != nil
    }

    // Check if expression has a result, if yes, calculString will be empty
    func add(number: String) {
        if expressionHaveResult {
            calculString = ""
        }
        calculString.append(number)
    }

    // Function allows to add an operator with condition (canAddOperator)
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

    // Function check the order of operations
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
            } else {
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

    // Function allows to get calcul if 2 conditions are correct
    func calculate() {
        guard expressionIsCorrect else {
            let dic = ["message": "Expression is not correct"]
            NotificationCenter.default.post(name: Notification.Name("error"), object: nil, userInfo: dic)
            return
        }
        guard expressionHaveEnoughElement else {
            let dic = ["message": "Expression has not enough elements"]
            NotificationCenter.default.post(name: Notification.Name("error"), object: nil, userInfo: dic)
            return
        }
        orderOfOperations()
    }
}
