//
//  CalculatorBrainCn.swift
//  Calculator
//
//  Created by 许龙 on 2017/3/16.
//  Copyright © 2017年 god-long. All rights reserved.
//

import Foundation

class CalculatorBrainCn {
    
    enum Op {
        case Operand(Double)
        case UnaryOperation(String, (Double) -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
    }
    
    var ops = [Op]()
    
    var knowsOps = [String:Op]()
    
    init() {
        knowsOps["×"] = Op.BinaryOperation("×", *)
        knowsOps["÷"] = Op.BinaryOperation("÷", /)
        knowsOps["−"] = Op.BinaryOperation("−", -)
        knowsOps["+"] = Op.BinaryOperation("+", +)
        knowsOps["√"] = Op.UnaryOperation("√", sqrt)
        knowsOps["%"] = Op.UnaryOperation("%"){ $0/100 }

    }
    
    func calculate() -> Double? {
        
        if !(ops.count == 2 || ops.count == 3) {
            return nil
        }
        
        switch ops[1] {
        case .UnaryOperation(_ , let unaryOperation):
            let result = unaryOperation(extractRelateValue(op: ops[0]) as! Double)
            ops.removeAll()
            pushOperand(operand: result)
            print(ops)
            return result
        case .BinaryOperation(_ , let binaryOperation):
            let result = binaryOperation(extractRelateValue(op: ops[0]) as! Double,extractRelateValue(op: ops[2]) as! Double)
            ops.removeAll()
            pushOperand(operand: result)
            print(ops)
            return result
        default: return nil
        }
    }
    
    
    func extractRelateValue(op: Op) -> Any {
        switch op {
        case .Operand(let operand):
            return operand
        case .UnaryOperation(_, let operation):
            return operation
        case .BinaryOperation(_, let operation):
            return operation
        }
    }
    
    
    ///操作数入栈
    func pushOperand(operand: Double) {
        if ops.count == 1 {
            ops[0] = Op.Operand(operand)
        }else {
            ops.append(Op.Operand(operand))
        }
        print(ops)
    }
    
    
    ///操作符入栈
    func pushOperation(symbol: String) -> Double? {
        
        switch ops.count {
        case 1:
            switch knowsOps[symbol]! {
            case Op.UnaryOperation(_, _):
                ops.append(knowsOps[symbol]!)
                print(ops)
                return calculate()
            case Op.BinaryOperation(_, _):
                ops.append(knowsOps[symbol]!)
                print(ops)
            default:
                assertionFailure("second is not a symbol")
            }
        case 2:
            ops.removeLast()
            print(ops)
            return pushOperation(symbol: symbol)
        case 3:
            switch knowsOps[symbol]! {
            case Op.UnaryOperation(_, _):
                _ = calculate()
                return pushOperation(symbol: symbol)
            case Op.BinaryOperation(_, _):
                defer {
                    ops.append(knowsOps[symbol]!)
                    print(ops)
                }
                return calculate()
            default:
                break
            }
        default: break
        }
 
        return nil
    }
    
    
    func clear() -> Double {
        ops.removeAll()
        return 0
    }
    
}
