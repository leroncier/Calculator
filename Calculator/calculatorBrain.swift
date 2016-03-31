//
//  calculatorBrain.swift
//  Calculator
//
//  Created by Charles Roncier on 15/12/2015.
//  Copyright © 2015 Charles Roncier. All rights reserved.
//

import Foundation

class CalculatorBrain
{
    private enum Op {
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
    }
    
    private var opStack = [Op]() //array
    
    private var knownOps = [String:Op]() //dictionnary
    
    init() {
        knownOps["×"] = Op.BinaryOperation("×", *)
        knownOps["÷"] = Op.BinaryOperation("÷") { $1 / $0 }
        knownOps["+"] = Op.BinaryOperation("+", +)
        knownOps["-"] = Op.BinaryOperation("-") { $1 - $0 }
        knownOps["√"] = Op.UnaryOperation("√",sqrt)
    }
    private func evaluate(ops: [Op]) -> (result: Double?, remainingOps: [Op]) {
        
        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            switch op {
            case .Operand(let operand):
                return (operand, remainingOps)
            case .UnaryOperation(_, let operation):
                let operandEvalutation = evaluate(remainingOps)
                if let operand = operandEvalutation.result {
                    return (operation(operand), operandEvalutation.remainingOps) }
            case .BinaryOperation(_, let operation):
                let op1Evaluation = evaluate(remainingOps)
                if let operand1 = op1Evaluation.result {
                    return (operation(operand1), operand)
                }
            }
        }
        return (nil, ops)
    }
    
    func evaluate() -> Double? {
        
    } //Use recursion : à checker.
    
    func pushOperand(operand: Double) {
    opStack.append(Op.Operand(operand))
    }
    
    func performOperation (symbol: String) {
        if let operation = knownOps[symbol]{
    opStack.append(operation)
    }
}