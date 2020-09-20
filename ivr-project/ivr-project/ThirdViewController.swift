//
//  ThirdViewController.swift
//  ivr-project
//
//  Created by Ирина Ким on 07.09.2020.
//  Copyright © 2020 Kim Irina. All rights reserved.
//

import Foundation
import UIKit

class ThirdViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPickerView()
    }


    func setupPickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.isHidden = true
    }

    @IBAction func buttonPressed(_ sender: Any) {
        pickerView.isHidden = false
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "123"
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.isHidden = true
    }
   


//       @IBOutlet var holder: UIView!
//
//       var firstNumber = 0
//           var resultNumber = 0
//           var currentOperations: Operation?
//
//           enum Operation {
//               case add, subtract
//           }
//
//           private var resultLabel: UILabel = {
//               let label = UILabel()
//               label.text = "0"
//               label.textColor = .white
//               label.textAlignment = .right
//               label.font = UIFont(name: "Helvetica", size: 100)
//               return label
//           }()
//
//
//
//           override func viewDidLayoutSubviews() {
//               super.viewDidLayoutSubviews()
//
//               setupNumberPad()
//           }
//
//
//
//           private func setupNumberPad() {
//               let FontSize:CGFloat = 25
//               let buttonSize: CGFloat = view.frame.size.width / 4
//
//
//               for x in 0..<3 {
//                   let button1 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height-(buttonSize), width: buttonSize, height: buttonSize))
//                   button1.setTitleColor(.black, for: .normal)
//                   button1.backgroundColor = .init(red: 0.93, green: 0.95, blue: 0.96, alpha: 1)
//                   button1.setTitle("\(x+1 - 1)", for: .normal)
//                   holder.addSubview(button1)
//                   button1.tag = x+2
//                   button1.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
//               }
//
//               for x in 0..<3 {
//                   let button2 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height-(buttonSize*2), width: buttonSize, height: buttonSize))
//                   button2.setTitleColor(.black, for: .normal)
//                   button2.backgroundColor = .init(red: 0.93, green: 0.95, blue: 0.96, alpha: 1)
//                   button2.setTitle("\(x+4 - 1)", for: .normal)
//                   holder.addSubview(button2)
//                   button2.tag = x+5
//                   button2.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
//               }
//
//
//               let clearButton = UIButton(frame: CGRect(x: buttonSize * 3 , y: holder.frame.size.height-(buttonSize*4), width: view.frame.size.width - buttonSize, height: buttonSize))
//               clearButton.setTitleColor(.black, for: .normal)
//               clearButton.backgroundColor = .init(red: 0.55, green: 0.6, blue: 0.68, alpha: 1)
//               clearButton.titleLabel?.font = UIFont(name: "Helvetica", size: FontSize-20)
//               clearButton.setTitle("CE", for: .normal)
//               holder.addSubview(clearButton)
//               clearButton.addTarget(self, action: #selector(clearResult), for: .touchUpInside)
//
//
//               let operations = ["=","+","-"]
//
//               for x in 0..<3 {
//                   let button_operand = UIButton(frame: CGRect(x: buttonSize * 3, y: holder.frame.size.height-(buttonSize * CGFloat(x+1)), width: buttonSize, height: buttonSize))
//                   button_operand.setTitleColor(.white, for: .normal)
//                   button_operand.backgroundColor = .init(red: 0.85, green: 0.0, blue: 0.2, alpha: 1.0)
//                   button_operand.setTitle(operations[x], for: .normal)
//                   button_operand.tag = x+1
//                   button_operand.titleLabel?.font = UIFont(name: "Helvetica", size: FontSize)
//                   holder.addSubview(button_operand)
//                   button_operand.addTarget(self, action: #selector(operationPressed(_:)), for: .touchUpInside)
//               }
//
//               resultLabel.frame = CGRect(x: 20, y: clearButton.frame.origin.y - 110.0, width: view.frame.size.width - 40, height: 100)
//               holder.addSubview(resultLabel)
//
//           }
//
//           @objc func clearResult() {
//               resultLabel.text = "0"
//               currentOperations = nil
//               firstNumber = 0
//           }
//
//           @objc func zeroTapped() {
//
//               if resultLabel.text != "0" {
//                   if let text = resultLabel.text {
//                       resultLabel.text = "\(text)\(0)"
//                   }
//               }
//           }
//
//
//           @objc func numberPressed(_ sender: UIButton) {
//               let tag = sender.tag - 2
//
//               if resultLabel.text == "0" {
//                   resultLabel.text = "\(tag)"
//               }
//               else if let text = resultLabel.text {
//                   resultLabel.text = "\(text)\(tag)"
//               }
//           }
//
//           @objc func operationPressed(_ sender: UIButton) {
//               let tag = sender.tag
//
//               if let text = resultLabel.text, let value = Int(text), firstNumber == 0 {
//                   firstNumber = value
//                   resultLabel.text = "0"
//               }
//
//               if tag == 1 {
//                   if let operation = currentOperations {
//                       var secondNumber = 0
//                       if let text = resultLabel.text, let value = Int(text) {
//                           secondNumber = value
//                       }
//
//                       switch operation {
//                       case .add:
//
//                           firstNumber = firstNumber + secondNumber
//                           secondNumber = 0
//                           resultLabel.text = "\(firstNumber)"
//                           currentOperations = nil
//                           firstNumber = 0
//
//                           break
//
//                       case .subtract:
//                           firstNumber = firstNumber - secondNumber
//                           secondNumber = 0
//                           resultLabel.text = "\(firstNumber)"
//                           currentOperations = nil
//                           firstNumber = 0
//
//                           break
//                       }
//                   }
//               }
//               else if tag == 2 {
//                   currentOperations = .add
//               }
//               else if tag == 3 {
//                   currentOperations = .subtract
//               }
//           }
               
}
        

    


