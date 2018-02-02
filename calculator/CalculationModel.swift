//
//  CalculationMeodel.swift
//  calculator
//
//  Created by Dina Vaingolts on 02/02/2018.
//  Copyright © 2018 Test. All rights reserved.
//

import Foundation
import RxSwift

class CalculationModel {
    
    var operation: Operator
    var operand1: Variable<Double?> = Variable(nil)
    var operand2: Variable<Double?> = Variable(nil)
    var result: Observable<String?>
    
    init(operation: Operator) {
        self.operation = operation
        result = Observable.combineLatest(operand1.asObservable(), operand2.asObservable()){ (o1, o2) -> String in
            guard let op1 = o1,
                  let op2 = o2 else { return "" }
            return String(operation.perform(op1, op2))
        }
    }
}
