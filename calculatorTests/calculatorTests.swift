//
//  calculatorTests.swift
//  calculatorTests
//
//  Created by Dina Vaingolts on 03/02/2018.
//  Copyright © 2018 Test. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa

@testable import calculator

class calculatorTests: XCTestCase {
    
    var vc: ViewController?
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController

        let _ = vc?.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testVC() {
        XCTAssertEqual(vc?.tableView.numberOfRows(inSection: 0), 4)
        let cell1 = vc?.tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        let cell2 = vc?.tableView.cellForRow(at: IndexPath(row: 1, section: 0))
        let cell3 = vc?.tableView.cellForRow(at: IndexPath(row: 2, section: 0))
        let cell4 = vc?.tableView.cellForRow(at: IndexPath(row: 3, section: 0))
        guard let calculationView1 = cell1?.contentView.superview?.viewWithTag(1000) as? CalculationView,
              let calculationView2 = cell2?.contentView.superview?.viewWithTag(1000) as? CalculationView,
              let calculationView3 = cell3?.contentView.superview?.viewWithTag(1000) as? CalculationView,
              let calculationView4 = cell4?.contentView.superview?.viewWithTag(1000) as? CalculationView else {
            XCTFail("not 4 calculation views")
            return
        }
        XCTAssertEqual(calculationView1.calculationModel?.operation.sign, Operator.addition.sign)
        XCTAssertEqual(calculationView2.calculationModel?.operation.sign, Operator.substraction.sign)
        XCTAssertEqual(calculationView3.calculationModel?.operation.sign, Operator.multiplication.sign)
        XCTAssertEqual(calculationView4.calculationModel?.operation.sign, Operator.division.sign)
        
        
    }
    
}

