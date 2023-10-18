//
//  Calculator - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class CalculatorViewController: UIViewController {
    
    
    
    @IBOutlet weak var NumbersLabel: UILabel!
    @IBOutlet weak var OperatorLabel: UILabel!
    
    var inputString: String = ""
    var currentNumbers: String = ""
    var currentOperator: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NumbersLabelUpdate()
        operatorLabelUpdate()
    }
    
    func NumbersLabelUpdate() {
        if currentNumbers.isEmpty {
            NumbersLabel.text = "0"
        } else {
            NumbersLabel.text = currentNumbers
        }
    }
    
    func operatorLabelUpdate() {
        if currentOperator.isEmpty {
            OperatorLabel.text = ""
        }
        OperatorLabel.text = currentOperator
    }
    
    @IBAction func touchUpInsideNumbers(_ sender: UIButton) {
        guard let number = sender.title(for: .normal) else {
            return
        }
        
        currentNumbers += number
        NumbersLabelUpdate()
    }
    
    @IBAction func touchUpInsideOperator(_ sender: UIButton) {
        guard let `operator` = sender.title(for: .normal) else {
            return
        }
        currentOperator = `operator`
        
        guard !currentNumbers.isEmpty else {
            operatorLabelUpdate()
            return
        }
        
        inputString += currentNumbers + currentOperator
        currentNumbers = ""
        
        NumbersLabelUpdate()
        operatorLabelUpdate()
        //스크롤뷰 업데이터도 호출 operator + currentNum

        print(inputString)
    }
    
}

