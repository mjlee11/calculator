//
//  ViewController.swift
//  Calculator
//
//  Created by Minjie Li on 6/28/16.
//  Copyright © 2016 Minjie Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var display: UILabel!
    var userIsInTheMiddleOfTypingNumber = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingNumber == false {
            display.text = digit
            userIsInTheMiddleOfTypingNumber = true
        } else {
            display.text = display.text! + digit
        }
        print("digit = \(digit)")
    }
    
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingNumber {
            enter()
        }
        
        let operation = sender.currentTitle!
        switch operation {
        case "+" : performOperation({$0 + $1})
        case "-" : performOperation({$1 - $0})
        case "✕" : performOperation({$1 * $0})
        case "÷" : performOperation({$1 / $0})
        case "√" : performOperation2({sqrt($0)})
        default:
            break
        }
    }
    
    func performOperation (operation: (Double , Double) -> Double){
        if operateStack.count >= 2 {
            displayValue = operation(operateStack.removeLast(), operateStack.removeLast())
            enter()
        }
        
    }
    
    func performOperation2 (operation: Double -> Double){
        if operateStack.count >= 1 {
            displayValue = operation(operateStack.removeLast())
            enter()
        }
        
    }
    
    
    var operateStack = Array<Double>()
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingNumber = false
        operateStack.append(displayValue)
        print(operateStack)
    }
    
    var displayValue: Double  {
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
            userIsInTheMiddleOfTypingNumber = false
        }
    }
    
}

