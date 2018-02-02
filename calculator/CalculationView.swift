//
//  calculationView.swift
//  calculator
//
//  Created by Dina Vaingolts on 31/01/2018.
//  Copyright © 2018 Test. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class CalculationView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var operand1TextField: UITextField!
    @IBOutlet weak var operand2TextField: UITextField!
    @IBOutlet weak var productTextField: UITextField!
    @IBOutlet weak var operationLabel: UILabel!
    
    var calculationModel: CalculationModelProtocol? {
        didSet {
            operationLabel.text = calculationModel?.operation.sign
            setupBinding()
        }
    }
    let disposeBag = DisposeBag()
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder aCoder: NSCoder) {
        super.init(coder: aCoder)!
        setup()
    }
    
    func setup() {
        Bundle.main.loadNibNamed("CalculationView", owner: self, options: [:])
        addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
    
    
    func setupBinding() {
        operand1TextField.keyboardType = .numberPad
        operand2TextField.keyboardType = .numberPad
        productTextField.isUserInteractionEnabled = false

        //prevent entering non digit input
        operand1TextField.rx.text
            .map{
                $0?.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            }
            .bind(to: operand1TextField.rx.text)
            .disposed(by:disposeBag)
        
        operand2TextField.rx.text.map{
                $0?.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            }
            .bind(to: operand2TextField.rx.text)
            .disposed(by:disposeBag)
        
        //bind textFields to model
        guard let calculationModelUnwraped = calculationModel else { return }
        
        operand1TextField.rx.text
            .filter{ $0 != nil }
            .map{ Double($0!) }
            .bind(to:calculationModelUnwraped.operand1)
            .disposed(by:disposeBag)
        
        operand2TextField.rx.text
            .filter{ $0 != nil }
            .map{ Double($0!) }
            .bind(to:calculationModelUnwraped.operand2)
            .disposed(by:disposeBag)
        
        calculationModelUnwraped.result
            .bind(to: productTextField.rx.text)
            .disposed(by:disposeBag)
    }
}
