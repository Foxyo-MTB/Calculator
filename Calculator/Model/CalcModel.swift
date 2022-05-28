//
//  CalcModel.swift
//  Calculator
//
//  Created by Vladimir Beliakov on 26.05.2022.
//

import Foundation
import UIKit

protocol CalcModelDelegate {
    func updateView(result: String)
}

struct CalcModel {
    
    var delegate: CalcModelDelegate?
    
    var value: Double = 0.0
    var action: String = ""
    var secondValue: Double = 0.0
    var secondValueActive: Bool = false
    
    mutating func getNumber(button: UIButton, labelText: String) {

        var currentString = labelText

        if secondValueActive {
            currentString = "0"
            secondValueActive = false
        }

        if let input = button.currentTitle {
            if input == numberGroup.ac {
                currentString = numberGroup.zero
                action = ""
            } else if input == numberGroup.sign {
                if currentString[currentString.startIndex] == Character(numberGroup.negative) {
                    currentString.remove(at: currentString.startIndex)
                } else {
                    currentString = numberGroup.negative + currentString
                }
            } else if input != numberGroup.dot && currentString == numberGroup.zero {
                currentString = input
            } else if input != numberGroup.dot && currentString == numberGroup.negative + numberGroup.zero {
                currentString = numberGroup.negative + input
            } else if input == numberGroup.percent {
                let decimal = (currentString as NSString).doubleValue
                currentString = String(decimal/100)
            } else if input == numberGroup.dot && currentString.contains(numberGroup.dot) {
                return
            }
            else {
                currentString += input
            }
        }


        if action == "" {
            value = (currentString as NSString).doubleValue
        } else {
            secondValue = (currentString as NSString).doubleValue
        }
        delegate?.updateView(result: currentString)
    }
    
    mutating func getAction(button: UIButton) {
        action = button.currentTitle ?? "No action"
        secondValueActive = true
    }
    
    mutating func getResult() {
        
        var result: Double
        
        switch action {
        case actionGroup.add:
            result = value + secondValue
        case actionGroup.minus:
            result = value - secondValue
        case actionGroup.multiply:
            result = value * secondValue
        case actionGroup.divide:
            result = value / secondValue
        default:
            return
        }
        value = result
        if result.truncatingRemainder(dividingBy: 1) == 0.0 {
            delegate?.updateView(result: String(Int(result)))
        } else {
            delegate?.updateView(result: String(result))
        }
        
    }
    
}


