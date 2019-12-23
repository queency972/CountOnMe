//
//  SimpleCalcTests.swift
//  SimpleCalcTests
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class SimpleCalcTests: XCTestCase {

    var calculator: Calculator!

    override func setUp() {
        super.setUp()
        calculator = Calculator()
    }

    // Error check computed variables
    func testGivenIsExpressionCorrect_WhenStringNumberContainNothing_ThenExpressionReturnFalse() {
        XCTAssertTrue(calculator.expressionIsCorrect)
    }

    // Check if "IsExpressionCorrect" is filled until Operator
    func testGivenIsNotExpressionCorrect_WhenExpressionTappedIsNotCorrect_ThenExpressionReturnFalse() {
        calculator.add(number: "1")
        calculator.add(operation: "+")
        calculator.calculate()

        XCTAssertFalse(calculator.expressionIsCorrect)
    }

    // Check if "IsExpressionCorrect".
    func testGivenIsExpressionCorrect_WhenExpressionTappedIsCorrect_ThenExpressionReturnTrue() {
        calculator.add(number: "1")

        XCTAssertTrue(calculator.expressionIsCorrect)
    }

    // Check if we can add + without number.
    func testGivenCanAddOperator_WhenStringNumberContainNothing_ThenCanAddOperatorReturnFalse() {
        calculator.add(number: "")
        calculator.add(operation: "+")

        XCTAssertFalse(calculator.canAddOperator)
    }

    // Check if we can add + after a number.
    func testGivenCanAddOperator_WhenStringNumberContainSomething_ThenCanAddOperatorReturnTrue() {
        calculator.add(number: "1")

        XCTAssertTrue(calculator.canAddOperator)
    }

    // Check if priority operation is respected. (*)
    func testGivenOrderOfOperations_WhenExpressionsContainsPlusAndMultiply_ThenMultiplicationIsPriority() {
        calculator.calculString = "3 + 3 x 3"
        calculator.calculate()

        XCTAssert(calculator.calculString == "3 + 3 x 3 = 12.0")
    }

    // Check if priority operation is respected. (/)
    func testGivenOrderOfOperations_WhenExpressionsContainsPlusAndDivide_ThenMultiplicationIsPriority() {
        calculator.calculString = "4 + 4 / 2"
        calculator.calculate()

        XCTAssert(calculator.calculString == "4 + 4 / 2 = 6.0")
    }

    func testGivenSimple_Operation_WhenCalculate_ThenGiveresult() {
        calculator.calculString = "2 + 3"
        calculator.calculate()

        XCTAssert(calculator.calculString == "2 + 3 = 5.0")
    }
    
    func testGivenExpressionHasTwoElements_WhenCheckingExpressionHasEnoughElements_ThenFalse() {
        calculator.calculString = "2 + "

        XCTAssertFalse(calculator.expressionHaveEnoughElement)
    }

    func testGivenExpressionHasOneElements_WhenExpressionHasNotEnoughElements_ThenFalse() {
        calculator.add(number: "1")
        calculator.calculate()
        
        XCTAssertFalse(calculator.expressionHaveEnoughElement)
    }

    func testGivenHasResult_WhenAddNewExpression_ThenAddExpressionIsTrue() {
        calculator.add(number: "1")
        calculator.add(operation: "+")
        calculator.add(number: "1")
        calculator.calculate()
        calculator.add(number: "1")

        XCTAssertTrue(calculator.calculString == "1")
    }

    // Check if priority operation is respected. (* & /)
    func testGivenOrderOfOperations_WhenElementsContainSomething_ThenElementsFollowsOrderOfOperations() {
        calculator.add(number: "1")
        calculator.add(operation: "-")
        calculator.add(number: "2")
        calculator.add(operation: "x")
        calculator.add(number: "8")
        calculator.add(operation: "/")
        calculator.add(number: "2")
        calculator.calculate()
        XCTAssert(true)
        XCTAssert(calculator.calculString == "1 - 2 x 8 / 2 = -7.0")
    }
}
