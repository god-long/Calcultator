//
//  ViewController.swift
//  Calculator
//
//  Created by 许龙 on 2017/3/15.
//  Copyright © 2017年 god-long. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false
    
    var calculatorBrain = CalculatorBrainCn()
    

    
    var displayValue: Double {
        get {
            return NumberFormatter().number(from: displayLabel.text!)!.doubleValue
        }
        set {
            displayLabel.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    /// 点击数字
    @IBAction func pressNumber(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            displayLabel.text = displayLabel.text! + digit
        }else {
            displayLabel.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    /// 点击操作符号 × ÷ + − √ %
    @IBAction func operate(_ sender: UIButton) {

        if userIsInTheMiddleOfTypingANumber {
            calculatorBrain.pushOperand(operand: displayValue)
        }
        
        let result = calculatorBrain.pushOperation(symbol: sender.currentTitle!)
        if result != nil {
            displayValue = result!
        }
        
        
        userIsInTheMiddleOfTypingANumber = false
    }

    
    
    /// 计算
    @IBAction func enter() {
        
        if userIsInTheMiddleOfTypingANumber {
            calculatorBrain.pushOperand(operand: displayValue)
        }
        
        let result = calculatorBrain.calculate()
        if result != nil {
            displayValue = result!
        }
        
        userIsInTheMiddleOfTypingANumber = false
    }
    
    /// 点击清空
    @IBAction func clear() {
        displayValue = calculatorBrain.clear()
        userIsInTheMiddleOfTypingANumber = false
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

