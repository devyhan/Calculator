//
//  ViewController.swift
//  Calculator
//
//  Created by 요한 on 2020/05/23.
//  Copyright © 2020 요한. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet private weak var displayLabel: UILabel!
    
    private var displayValue: String {
        get { return displayLabel.text ?? "" }
        set { displayLabel.text = newValue }
    }
    
    private var shouldResetText = true
    private var accumelator = 0.0
    private var bufferOperator: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func didTapButton(_ sender: UIButton) {
        guard let input = sender.currentTitle  else { return }
        
        let commend: Command
        switch input {
        case "AC":
            commend = .clear
        case "=":
            commend = .equal
        case "+", "-", "×", "÷":
            commend = .operation(input)
        default:
            commend = .addDigit(input)
        }
        
        displayValue = performCommand(commend, with: displayValue)
        print("display : \(displayValue), command : \(commend)")
    }
    
    private func addDight(value newValue: String, to oldValue: String) -> String {
        let displayStirng = shouldResetText ? newValue
            : oldValue.count > 13 ? oldValue
            : oldValue + newValue
        shouldResetText = false 
        return displayStirng
    }
    
    private func calculate(for newValue: String) -> Double {
        let operand = Double(newValue)!
        
        switch bufferOperator {
        case "+": return accumelator + operand
        case "-": return accumelator - operand
        case "×": return accumelator * operand
        case "÷": return accumelator / operand
        default: return operand
        }
    }
    
    private func performCommand(_ command: Command, with displayText: String) -> String {
        var result: Double?
        
        switch command {
        case .addDigit(let input):
            return addDight(value: input, to: displayText)
        case .operation(let op):
            accumelator = calculate(for: displayText)
            bufferOperator = op
            result = accumelator
        case .equal:
            break
        case .clear:
            break
        }
        shouldResetText = true
        return String(result ?? 0)
    }
}
