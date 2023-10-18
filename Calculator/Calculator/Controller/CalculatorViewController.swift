//
//  Calculator - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class CalculatorViewController: UIViewController {
    @IBOutlet weak var numbersLabel: UILabel!
    @IBOutlet weak var operatorLabel: UILabel!
    
    var inputString: String = ""
    var currentNumbers: String = ""
    var currentOperator: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numbersLabelUpdate()
        operatorLabelUpdate()
    }
    
    func numbersLabelUpdate() {
        if currentNumbers.isEmpty {
            numbersLabel.text = "0"
        } else {
            numbersLabel.text = currentNumbers.numberFormatter()
        }
    }
    
    func operatorLabelUpdate() {
        if currentOperator.isEmpty {
            operatorLabel.text = ""
        }
        operatorLabel.text = currentOperator
    }
    
    @IBAction func touchUpInsideNumbers(_ sender: UIButton) {
        guard let number = sender.title(for: .normal) else {
            return
        }
        
        currentNumbers += number
        numbersLabelUpdate()
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
        
        numbersLabelUpdate()
        operatorLabelUpdate()
        //스크롤뷰 업데이터도 호출 operator + currentNum

        print(inputString)
    }
    
    
    @IBAction func touchUpInsideReverseSign(_ sender: UIButton) {
        guard !currentNumbers.isEmpty else {
            return
        }
        
        if currentNumbers.first == "-" {
            currentNumbers.removeFirst()
        } else {
            currentNumbers = "-" + currentNumbers
        }
        
        numbersLabelUpdate()
    }
    
    @IBAction func touchUpInsideAC(_ sender: UIButton) {
        inputString = ""
        currentNumbers = ""
        currentOperator = ""
        
        numbersLabelUpdate()
        operatorLabelUpdate()
    }
    
    
    @IBAction func touchUpInsideCE(_ sender: UIButton) {
        currentNumbers = ""
        
        numbersLabelUpdate()
    }
    
    
    @IBAction func touchUpInsideZero(_ sender: UIButton) {
        guard let zero = sender.title(for: .normal) else {
            return
        }
        
        guard !currentNumbers.isEmpty else {
            return
        }
        
        currentNumbers += zero
        numbersLabelUpdate()
    }
    
    @IBAction func touchUpInsidePeriod(_ sender: UIButton) {
        if currentNumbers.isEmpty {
            currentNumbers += "0."
        } else {
            currentNumbers += "."
        }
        
        numbersLabelUpdate()
    }
    
    
    @IBAction func touchUpInsideEqual(_ sender: UIButton) {
        if !currentNumbers.isEmpty {
            inputString += currentNumbers
        }
        
        var formula = ExpressionParser.parse(from: inputString)
        let result = formula.result()
        
        if result.haveDecimalPlace() {
            currentNumbers = String(result)
        } else {
            currentNumbers = String(Int(result))
        }
        
        numbersLabelUpdate()
        operatorLabelUpdate()
        
        inputString = ""
        currentNumbers = ""
        currentOperator = ""
    }
}

