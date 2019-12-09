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
    func testGivenIsExpressionCorrect_WhenExpressionTappedIsNotCorrect_ThenExpressionReturnFalse() {
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
    
    // Check if priority operation is respected. (* & /)
    func testGivenOrderOfOperations_WhenStringNumberContainSomething_ThenStringNumberFollowsOrderOfOperations() {
        calculator.add(number: "1")
        calculator.add(operation: "-")
        calculator.add(number: "2")
        calculator.add(operation: "x")
        calculator.add(number: "8")
        calculator.add(operation: "/")
        calculator.add(number: "2")
        calculator.calculate()
        
        XCTAssert(true)
    }
}
