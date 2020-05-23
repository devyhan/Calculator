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
        
        displayValue = input
        print("display : \(displayValue), command : \(commend)")
        
    }
}
