//
//  CalculaterViewController.swift
//  ivr-project
//
//  Created by Ирина Ким on 20.09.2020.
//  Copyright © 2020 Kim Irina. All rights reserved.
//

import Foundation
import UIKit
import PanModal

//ПЛАН
// 1. Запретить лишние символы
// 2.


class CalculatorViewController: UIViewController {

    var togle: Bool = false
    var subjectMarks = [Mark]() {
        didSet {
            getResultMark()
        }
    }

    var subjectWeigts = [
        "Констатирующая": 0.0,
        "Формирующая": 0.0,
        "Творческая": 0.0
    ]

    var resultMark: Double = 0.0 {
        willSet {
            resultTextField.text = String(newValue.rounded(toPlaces: 3))
        }
    }
    
    let calculatorLabel: UILabel = {
        let label = UILabel()
        label.text = "Калькулятор"
        label.textColor = UIColor(red: 0.17, green: 0.18, blue: 0.26, alpha: 1.0)
        label.font = UIFont.boldSystemFont(ofSize: 30.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let subjects = ["Математика", "Физика", "Русский", "Биология"]

    var subjectButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor( UIColor(red: 0.85, green: 0.0, blue: 0.2, alpha: 1), for: .normal)
        button.setTitle("Предмет", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(subjectHandler), for: .touchUpInside)
        return button
    }()

    let markTypes = ["Констатирующая", "Формирующая", "Творческая"]
    var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Констатирующая", "Формирующая", "Творческая"])
        control.backgroundColor = .init(red: 0.85, green: 0.0, blue: 0.2, alpha: 1)
        control.selectedSegmentIndex = 0
        control.translatesAutoresizingMaskIntoConstraints = false
        let font = UIFont.systemFont(ofSize: 11)
        control.setTitleTextAttributes([NSAttributedString.Key.font : font], for: .normal)
        control.addTarget(self, action: #selector(segmentedHandler), for: .valueChanged)
        return control
    }()

    @objc
    private func segmentedHandler() {
        weightTextField.text = String(subjectWeigts[markTypes[segmentedControl.selectedSegmentIndex]]!)
    }

    var marksTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Оценки"
        field.backgroundColor = .init(red: 0.85, green: 0.0, blue: 0.2, alpha: 0.5)
        field.layer.cornerRadius = 10
        field.keyboardType = UIKeyboardType.decimalPad
        field.setLeftPaddingPoints(16.0)
        field.setRightPaddingPoints(16.0)
        return field
    }()

    var resultTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = .init(red: 0.43, green: 0.45, blue: 0.66, alpha: 0.5)
        field.placeholder = "Результат"
        field.layer.cornerRadius = 10
        field.setLeftPaddingPoints(16.0)
        field.setRightPaddingPoints(16.0)
        field.textAlignment = .center
        field.isUserInteractionEnabled = false
        return field
    }()

    let weightTextField: WeightTextFeild = {
        let field = WeightTextFeild()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = .init(red: 0.43, green: 0.45, blue: 0.66, alpha: 0.5)
        field.layer.cornerRadius = 10
        field.keyboardType = UIKeyboardType.decimalPad
        field.setLeftPaddingPoints(16.0)
        field.setRightPaddingPoints(16.0)
        field.textAlignment = .center
        return field
    }()

    
    
    let logOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Выйти", for: .normal)
        button.tintColor = .init(red: 0.85, green: 0.0, blue: 0.2, alpha: 1)
        button.sizeToFit()
        button.addTarget(self, action: #selector(logOutHandler), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        marksTextField.delegate = self
        setupUI()
        getMarks()

    }

    func setupUI() {
        view.addSubview(subjectButton)
        view.addSubview(segmentedControl)
        view.addSubview(marksTextField)
        view.addSubview(resultTextField)
        view.addSubview(calculatorLabel)
        view.addSubview(logOutButton)
        view.addSubview(weightTextField)
//
//        pickerView.delegate = self
//        pickerView.dataSource = self

        view.backgroundColor = .white
        
        calculatorLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 128).isActive = true
        calculatorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32.0).isActive = true


        marksTextField.topAnchor.constraint(equalTo: calculatorLabel.topAnchor, constant: 64.0).isActive = true
        marksTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        marksTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        marksTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32.0).isActive = true
        marksTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32.0).isActive = true
        
        
        resultTextField.topAnchor.constraint(equalTo: marksTextField.bottomAnchor, constant: 4.0).isActive = true
        resultTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        resultTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        resultTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32.0).isActive = true
        resultTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32.0).isActive = true

        
        segmentedControl.topAnchor.constraint(equalTo: resultTextField.bottomAnchor, constant: 16.0).isActive = true
        segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32.0).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32.0).isActive = true

        weightTextField.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16.0).isActive = true
        weightTextField.widthAnchor.constraint(equalToConstant: 80).isActive = true
        weightTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        weightTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true

        subjectButton.topAnchor.constraint(equalTo: weightTextField.bottomAnchor, constant: 4.0).isActive = true
        subjectButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32.0).isActive = true
        subjectButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32.0).isActive = true
        subjectButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        logOutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16.0).isActive = true
        logOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0).isActive = true
    }


    //MARK: - Handlers
    @objc private func subjectHandler() {
        let subjectsVC = SubjectsTableViewController()
        subjectsVC.calculaterViewController = self
        presentPanModal(subjectsVC)
    }

    @objc private func logOutHandler() {
        dismiss(animated: true, completion: nil)
    }


    //MARK: - Network response

    //TODO: Вынести куда-нибудь
    private func getMarks() {
        NetworkSerivce.getMarks(
            //TODO: Сделать динмаческую дату
            days: "20200901-20201231",
            completionHandler: {result in
                switch result {
                case .success(let marks):
                    print(marks)
                case .failure(let error):
                    print("Ошибка получения оценок: \(error)")
                }
            }
        )
    }

    //MARK: - Calculation result
    func getResultMark() {

        //Веса оценок
        var v1: Double = 0 // вес К
        var v2: Double = 0 // вес F
        var v3: Double = 0 // вес Т

        // Средние оценки
        var K: Double // Констатирующая
        var F: Double // Формирующая
        var T: Double // Творческая

        var tempK = 0
        var tempF = 0
        var tempT = 0

        var countK = 0
        var countF = 0
        var countT = 0

        for mark in subjectMarks {

            switch mark.type {
            case "Констатирующая":
                if let weight = mark.weight, let doubleValue = Double(weight) {
                    v1 = doubleValue
                }
                if let value = mark.value, value != "н", let intValue = Int(value) {
                    tempK += intValue
                    countK += 1
                }

            case "Формирующая":
                if let weight = mark.weight, let doubleValue = Double(weight) {
                    v2 = doubleValue
                }
                if let value = mark.value, value != "н", let intValue = Int(value) {
                    tempF += intValue
                    countF += 1
                }
            case "Творческая":
                if let weight = mark.weight, let doubleValue = Double(weight) {
                    v3 = doubleValue
                }
                if let value = mark.value, value != "н", let intValue = Int(value) {
                    tempT += intValue
                    countT += 1
                }
            default:
                continue
            }
        }

        if countK > 0 {
            K = Double(tempK)/Double(countK)
        } else {
            K = 0
        }

        if countF > 0 {
            F = Double(tempF)/Double(countF)
        } else {
            F = 0
        }

        if countT > 0 {
            T = Double(tempT)/Double(countT)
        } else {
            T = 0
        }

        subjectWeigts["Констатирующая"] = v1
        subjectWeigts["Формирующая"] = v2
        subjectWeigts["Творческая"] = v3
        weightTextField.text = String(subjectWeigts[markTypes[segmentedControl.selectedSegmentIndex]]!)
        self.resultMark = K*v1 + F*v2 + T*v3
    }

}

extension CalculatorViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let isValidSymbol = [" ", "0", "1", "2", "3", "4", "5", "н"].contains(string)

        if isValidSymbol {
            guard string != " " else {
                return true
            }

            var newMark = Mark()
            newMark.value = string
            newMark.type = markTypes[segmentedControl.selectedSegmentIndex]
            newMark.weight = weightTextField.text

            subjectMarks.append(newMark)
        }

        return isValidSymbol
    }

}

