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

class CalculatorViewController: UIViewController {

    var togle: Bool = false
    var subjectMarks = [Mark]() {
        willSet {
            print(newValue)
            let marksString = newValue.reduce("") {
                guard let value = $1.value else {
                    return $0
                }
                return $0 + " " + value
            }
            marksTextField.text = marksString
//
//            let weightsString = newValue.reduce("") { $0 + " " + String($1.1) }
//            weightTextField.text = weightsString
        }
    }

    var resultMark: Double = 0.0 {
        willSet {
            resultTextField.text = String(newValue)
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
    let pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.isHidden = true
        return picker
    }()

    var subjectButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor( UIColor(red: 0.85, green: 0.0, blue: 0.2, alpha: 1), for: .normal)
        button.setTitle("Предмет", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(subjectHandler), for: .touchUpInside)
        return button
    }()

    var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Констатирующая", "Формирующая", "Творческая"])
        control.backgroundColor = .init(red: 0.85, green: 0.0, blue: 0.2, alpha: 1)
        control.selectedSegmentIndex = 0
        control.translatesAutoresizingMaskIntoConstraints = false
        let font = UIFont.systemFont(ofSize: 11)
        control.setTitleTextAttributes([NSAttributedString.Key.font : font], for: .normal)
        return control
    }()

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

    var weightTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = .init(red: 0.55, green: 0.60, blue: 0.68, alpha: 0.5)
        field.placeholder = "Коэффициент оценки"
        field.layer.cornerRadius = 10
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
        setupUI()
        getMarks()

    }

    func setupUI() {
        view.addSubview(subjectButton)
        view.addSubview(segmentedControl)
        view.addSubview(marksTextField)
        view.addSubview(resultTextField)
        view.addSubview(pickerView)
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
        

        weightTextField.topAnchor.constraint(equalTo: marksTextField.bottomAnchor, constant: 4.0).isActive = true
        weightTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        weightTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        weightTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32.0).isActive = true
        weightTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32.0).isActive = true
        
        
        resultTextField.topAnchor.constraint(equalTo: weightTextField.bottomAnchor, constant: 4.0).isActive = true
        resultTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        resultTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        resultTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32.0).isActive = true
        resultTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32.0).isActive = true
        
        
        segmentedControl.topAnchor.constraint(equalTo: resultTextField.bottomAnchor, constant: 16.0).isActive = true
        segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32.0).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32.0).isActive = true
        
        
        subjectButton.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 4.0).isActive = true
        subjectButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32.0).isActive = true
        subjectButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32.0).isActive = true
        subjectButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        

        pickerView.topAnchor.constraint(equalTo: subjectButton.bottomAnchor, constant: 4.0).isActive = true
        pickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pickerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        pickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32.0).isActive = true
        pickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32.0).isActive = true

        
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

    private func getMarks() {
        NetworkSerivce.getMarks(
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

        //TODO: УДАЛИТЬ!!!
//        for i in 0...subjectMarks.count - 1 {
//            subjectMarks[i].weight = ["0.25", "0.5", "0.75"].randomElement()
//        }
        subjectMarks = subjectMarks.map { (mark: Mark) -> Mark in
            let newWeight = ["0.25", "0.5", "0.75"].randomElement()
            let newType = ["Констатирующая", "Формирующая", "Творческая"].randomElement()
            return Mark(type: newType, weight: newWeight, value: mark.value)
        }

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

        self.resultMark = K*v1 + F*v2 + T*v3
    }

    
    
}




