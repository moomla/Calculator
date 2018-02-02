//
//  definitions.swift
//  calculator
//
//  Created by Dina Vaingolts on 31/01/2018.
//  Copyright © 2018 Test. All rights reserved.
//

import Foundation

public enum Operator: String {
    case addition
    case substraction
    case multiplication
    case division
    
    var sign: String {
        switch self {
        case .addition:         return "+"
        case .substraction:      return "-"
        case .multiplication:   return "×"
        case .division:         return "/"
        }
    }
    
    var perform: (Double, Double) -> Double {
        switch self {
        case .addition:         return (+)
        case .substraction:      return (-)
        case .multiplication:   return (*)
        case .division:         return (/)
        }
    }
}
