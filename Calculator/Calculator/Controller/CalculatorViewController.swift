//
//  Calculator - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class CalculatorViewController: UIViewController {
    @IBOutlet weak var numbersLabel: UILabel!
    @IBOutlet weak var operatorLabel: UILabel!
    
    @IBOutlet weak var scrollStack: UIStackView!
    @IBOutlet weak var scroll: UIScrollView!
    
    var inputString: String = ""
    var currentNumbers: String = ""
    var currentOperator: String = ""
    
    var tempEqual: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numbersLabelUpdate(label: numbersLabel)
        operatorLabelUpdate(label: operatorLabel)
    }
    
    func numbersLabelUpdate(label: UILabel) {
        if currentNumbers.isEmpty {
            label.text = "0"
        } else {
            label.text = currentNumbers.numberFormatter()
        }
    }
    
    func operatorLabelUpdate(label: UILabel) {
        if currentOperator.isEmpty {
            label.text = ""
        }
        label.text = currentOperator
    }
    
    @IBAction func touchUpInsideNumbers(_ sender: UIButton) {
        guard let number = sender.title(for: .normal) else {
            return
        }
        if let temp = tempEqual {
            tempEqual = nil
        }
        
        currentNumbers += number
        numbersLabelUpdate(label: numbersLabel)
    }
    
    @IBAction func touchUpInsideOperator(_ sender: UIButton) {
        guard let `operator` = sender.title(for: .normal) else {
            return
        }
        
        if let temp = tempEqual {
            currentNumbers = temp
            tempEqual = nil
        }
            
        guard !currentNumbers.isEmpty else {
            currentOperator = `operator`
            operatorLabelUpdate(label: operatorLabel)
            return
        }
        
        
        scrollStack.addArrangedSubview(makeScrollStack())
        
        scroll.layoutIfNeeded()
        scroll.setContentOffset(CGPoint(x: 0, y: scroll.contentSize.height - scroll.bounds.height), animated: false)
        
        currentOperator = `operator`

        inputString += currentNumbers + currentOperator
        currentNumbers = ""
        
        numbersLabelUpdate(label: numbersLabel)
        operatorLabelUpdate(label: operatorLabel)
    }
    
    func makeScrollStack() -> UIStackView {
        let stackView = UIStackView()
        let operatorLabel = UILabel()
        let numbersLabel = UILabel()
        
        operatorLabelUpdate(label: operatorLabel)
        numbersLabelUpdate(label: numbersLabel)
        
        operatorLabel.textColor = .white
        numbersLabel.textColor = .white
        
        operatorLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        numbersLabel.font = UIFont.preferredFont(forTextStyle: .title3)
                
        stackView.addArrangedSubview(operatorLabel)
        stackView.addArrangedSubview(numbersLabel)
        
        return stackView
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
        
        numbersLabelUpdate(label: numbersLabel)
    }
    
    @IBAction func touchUpInsideAC(_ sender: UIButton) {
        inputString = ""
        currentNumbers = ""
        currentOperator = ""
        
        numbersLabelUpdate(label: numbersLabel)
        operatorLabelUpdate(label: operatorLabel)
        
        scrollStack.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
    }
    
    
    @IBAction func touchUpInsideCE(_ sender: UIButton) {
        currentNumbers = ""
        
        numbersLabelUpdate(label: numbersLabel)
    }
    
    
    @IBAction func touchUpInsideZero(_ sender: UIButton) {
        guard let zero = sender.title(for: .normal) else {
            return
        }
        
        guard !currentNumbers.isEmpty else {
            return
        }
        
        currentNumbers += zero
        numbersLabelUpdate(label: numbersLabel)
    }
    
    @IBAction func touchUpInsidePeriod(_ sender: UIButton) {
        if currentNumbers.isEmpty {
            currentNumbers += "0."
        } else {
            currentNumbers += "."
        }
        
        numbersLabelUpdate(label: numbersLabel)
    }
    
    
    @IBAction func touchUpInsideEqual(_ sender: UIButton) {
        if !currentNumbers.isEmpty {
            inputString += currentNumbers
        }
        
        var formula = ExpressionParser.parse(from: inputString)
        let result = formula.result()

        if result.isNaN {
            currentNumbers = "NaN"
        } else if result.haveDecimalPlace() {
            currentNumbers = String(result)
        } else {
            currentNumbers = String(Int(result))
        }
    
        inputString = ""
        currentOperator = ""
        
        numbersLabelUpdate(label: numbersLabel)
        operatorLabelUpdate(label: operatorLabel)
        tempEqual = currentNumbers
        currentNumbers = ""
    }
}

