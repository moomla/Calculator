//
//  calculatorModelTests.swift
//  calculatorTests
//
//  Created by Dina Vaingolts on 03/02/2018.
//  Copyright © 2018 Test. All rights reserved.
//
import Foundation
import XCTest
import RxSwift

@testable import calculator

class calculatorModelTests: XCTestCase {
    
    var model: CalculationModel?
    
    
    var disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func updateModel(operation: Operator, op1: Double, op2: Double) {
        model = CalculationModel(operation: operation)
        Observable.just(op1).bind(to: (model?.operand1)!).disposed(by: disposeBag)
        Observable.just(op2).bind(to: (model?.operand2)!).disposed(by: disposeBag)
    }
    
    
    func testOperations() {
        let op1 = Double(arc4random_uniform(1000))
        let op2 = Double(arc4random_uniform(1000))
        updateModel(operation: .addition, op1: op1, op2: op2)
        model?.result.subscribe(onNext: { value in
            XCTAssertNotNil(value)
            XCTAssertEqual(Double(value!), op1+op2)
        })
            .disposed(by: disposeBag)
    
        updateModel(operation: .substraction, op1: op1, op2: op2)
        model?.result.subscribe(onNext: { value in
            XCTAssertNotNil(value)
            XCTAssertEqual(Double(value!), op1-op2)
        })
            .disposed(by: disposeBag)
    
        updateModel(operation: .multiplication, op1: op1, op2: op2)
        model?.result.subscribe(onNext: { value in
            XCTAssertNotNil(value)
            XCTAssertEqual(Double(value!), op1*op2)
        })
            .disposed(by: disposeBag)
    
        
        updateModel(operation: .division, op1: op1, op2: op2)
        model?.result.subscribe(onNext: { value in
            XCTAssertNotNil(value)
            if let result = Double(value!) {
                XCTAssertTrue(result - Double(op1/op2) < 0.000001)
            }
        })
            .disposed(by: disposeBag)
    }
    
    func test2Zero() {
        let op1 = Double(arc4random_uniform(1000))
        let op2 = 0.0
        updateModel(operation: .addition, op1: op1, op2: op2)
        model?.result.subscribe(onNext: { value in
            XCTAssertNotNil(value)
            XCTAssertEqual(Double(value!), op1)
        })
            .disposed(by: disposeBag)

        updateModel(operation: .substraction, op1: op1, op2: op2)
        model?.result.subscribe(onNext: { value in
            XCTAssertNotNil(value)
            XCTAssertEqual(Double(value!), op1)
        })
            .disposed(by: disposeBag)
        
        updateModel(operation: .multiplication, op1: op1, op2: op2)
        model?.result.subscribe(onNext: { value in
            XCTAssertNotNil(value)
            XCTAssertEqual(Double(value!), 0)
        })
            .disposed(by: disposeBag)
        
        updateModel(operation: .division, op1: op1, op2: op2)
        model?.result.subscribe(onNext: { value in
            XCTAssertNotNil(value)
            XCTAssertEqual(value, "inf")
        })
            .disposed(by: disposeBag)
    }

    func test1Zero() {
        let op1 = 0.0
        let op2 = Double(arc4random_uniform(1000))
        
        updateModel(operation: .substraction, op1: op1, op2: op2)
        model?.result.subscribe(onNext: { value in
            XCTAssertNotNil(value)
            XCTAssertEqual(Double(value!), -op2)
        })
            .disposed(by: disposeBag)
        
        updateModel(operation: .multiplication, op1: op1, op2: op2)
        model?.result.subscribe(onNext: { value in
            XCTAssertNotNil(value)
            XCTAssertEqual(Double(value!), 0)
        })
            .disposed(by: disposeBag)
        
        updateModel(operation: .division, op1: op1, op2: op2)
        model?.result.subscribe(onNext: { value in
            XCTAssertNotNil(value)
            XCTAssertEqual(Double(value!), 0.0)
        })
            .disposed(by: disposeBag)
    }

}
