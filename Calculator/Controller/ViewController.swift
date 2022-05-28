//
//  ViewController.swift
//  Calculator
//
//  Created by Vladimir Beliakov on 21.05.2022.
//

import UIKit

class ViewController: UIViewController  {
    
    @IBOutlet weak var resultView: UILabel!
    
    
    var calcActions = CalcModel()
    var pressedNumber: String?
    var presserAction: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calcActions.delegate = self
        resultView.text = "0" // setting value to 0 for correct calculating
    }
    
}

extension ViewController: CalcModelDelegate {
    //MARK: - Numbers pressing
    
    @IBAction func numberButtonPressed(_ sender: UIButton) {
        calcActions.getNumber(button: sender, labelText: resultView.text!)
    }
    
    //MARK: - Actions performing
    
    @IBAction func actionButtonPressed(_ sender: UIButton) {
        calcActions.getAction(button: sender)
    }
    
    @IBAction func resultButtonPerssed(_ sender: UIButton) {
        calcActions.getResult()
    }
    
    func updateView(result: String) {
        resultView.text = result
    }
    
    
}

