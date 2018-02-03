//
//  calculationViewTests.swift
//  calculatorTests
//
//  Created by Dina Vaingolts on 31/01/2018.
//  Copyright © 2018 Test. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa

@testable import calculator

class calculationViewTests: XCTestCase {

    var model: CalculationModel?
    var op1: Double?
    var op2: Double?
    var calculationView =  CalculationView()
    var disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
    }
    
    func setupViewWithFullModel(operation: Operator){
        let newModel = CalculationModel(operation:operation)
        op1 = Double(arc4random_uniform(1000))
        op2 = Double(arc4random_uniform(1000))
        newModel.operand1 = Variable(op1)
        newModel.operand2 = Variable(op2)
        model = newModel
        calculationView.calculationModel = model
    }
    
    func setupViewWithModelWithoutValues(operation: Operator){
        let newModel = CalculationModel(operation:operation)
        model = newModel
        calculationView.calculationModel = model
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddition() {
        
        setupViewWithFullModel(operation: .addition)
        
        XCTAssertEqual(String(describing: op1), calculationView.operand1TextField.text)
        XCTAssertEqual(String(describing: op2), calculationView.operand2TextField.text)
        
        guard let resultModel = model?.result else {
            XCTFail("no result")
            return
        }
        Observable.combineLatest(calculationView.productTextField.rx.text.asObservable(), resultModel){ $0 == $1 }
            .subscribe(onNext: { value in
                XCTAssertTrue(value)
            })
            .disposed(by: disposeBag)
    }
    
    func testEmptyModel() {
        
        setupViewWithModelWithoutValues(operation: .addition)
        
        if calculationView.operand1TextField.text?.count != 0 ||
           calculationView.operand2TextField.text?.count != 0 ||
           calculationView.productTextField.text?.count != 0 {
                XCTFail("fields are not empty")
            }
    }
    
}
