//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by 许龙 on 2017/3/15.
//  Copyright © 2017年 god-long. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    private enum Op {
        case Operand(Double)
        case UnaryOperation(String,(Double) -> Double)
        case BinaryOperation(String,(Double, Double) -> Double)
    }
    
    private var opStack = [Op]()

    private var knowOps = [String:Op]()
    
    init() {
        knowOps["×"] = Op.BinaryOperation("×", *)
        knowOps["÷"] = Op.BinaryOperation("÷"){ $1 / $0 }
        knowOps["+"] = Op.BinaryOperation("+", *)
        knowOps["−"] = Op.BinaryOperation("−"){ $1 - $0 }
        knowOps["√"] = Op.UnaryOperation("√", sqrt)

    }
    
//    private func evalutate(ops: inout [Op]) -> (result: Double?, remindOps: [Op]) {
//        
//        if ops.isEmpty {
//            return (nil, [Op]())
//        }else {
//            for _ in 0 ..< ops.count {
//                let op = ops.removeLast()
//                switch op {
//                case let .BinaryOperation(symbol, operation) = op:
//                    x
//                default:
//                    <#code#>
//                }
//            }
//        }
//    }
    
//    func evaluate() -> Double? {
//        
//    }
    
//    func pushOperand(operand: Double) {
//        opStack.append(.Operand(operand))
//    }
//    
//    func performOperation(symbol: String) {
//        if let operation = knowOps[symbol] {
//            opStack.append(operation)
//        }
//    }
    
}
