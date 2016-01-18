//
//  ViewController.swift
//  Calculator
//
//  Created by Charles Roncier on 28/09/2015.
//  Copyright © 2015 Charles Roncier. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var userTyping: Bool = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userTyping {
            display.text = display.text! + digit}
        else {
            display.text = digit
            userTyping = true }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userTyping {
            enter()
        }
        switch operation {
        case "×": performOperation { $0 * $1 }
        case "÷": performOperation { $1 / $0 }
        case "+": performOperation { $0 + $1 }
        case "-": performOperation { $1 * $0 }
        case "√": performOperation { sqrt($0) }
        default: break
        }
    }
    
    func performOperation (operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }

    }
   @nonobjc
    func performOperation (operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
        
    }
    var operandStack = Array<Double>()

    @IBAction func enter() {
        userTyping = false
        operandStack.append(displayValue)
        print("operandStack = \(operandStack)")
    }

    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userTyping = false
        }
    }


}

