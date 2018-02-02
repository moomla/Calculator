//
//  ViewController.swift
//  calculator
//
//  Created by Dina Vaingolts on 31/01/2018.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UITableViewController {
    
    let disposeBag = DisposeBag()
    @IBOutlet weak var additionView: CalculationView!
    @IBOutlet weak var substructionView: CalculationView!
    @IBOutlet weak var multiplicationView: CalculationView!
    @IBOutlet weak var divisionView: CalculationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        additionView.operation = .addition
        substructionView.operation = .substraction
        multiplicationView.operation = .multiplication
        divisionView.operation = .division
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
