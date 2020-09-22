//
//  CalculaterViewController.swift
//  ivr-project
//
//  Created by Ирина Ким on 20.09.2020.
//  Copyright © 2020 Kim Irina. All rights reserved.
//

import Foundation
import UIKit

class CalculatorViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

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
        let control = UISegmentedControl(items: ["К", "Ф", "Т"])
        control.backgroundColor = .init(red: 0.85, green: 0.0, blue: 0.2, alpha: 1)
        control.selectedSegmentIndex = 0
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()

    var marksTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Оценки"
        field.backgroundColor = .init(red: 0.85, green: 0.0, blue: 0.2, alpha: 0.5)
        field.layer.cornerRadius = 10
        field.keyboardType = UIKeyboardType.decimalPad
        return field
    }()

    var resultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Результат"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        view.addSubview(subjectButton)
        view.addSubview(segmentedControl)
        view.addSubview(marksTextField)
        view.addSubview(resultLabel)
        view.addSubview(pickerView)

        pickerView.delegate = self
        pickerView.dataSource = self

        view.backgroundColor = .white
        subjectButton.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 16.0).isActive = true
        subjectButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 64.0).isActive = true
        subjectButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64.0).isActive = true
        subjectButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

        segmentedControl.topAnchor.constraint(equalTo: subjectButton.bottomAnchor, constant: 16.0).isActive = true
        segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        segmentedControl.widthAnchor.constraint(equalToConstant: 128).isActive = true

        marksTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 228.0).isActive = true
        marksTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        marksTextField.heightAnchor.constraint(equalToConstant: 80).isActive = true
        marksTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32.0).isActive = true
        marksTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32.0).isActive = true

        resultLabel.topAnchor.constraint(equalTo: marksTextField.bottomAnchor, constant: 16.0).isActive = true
        resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        resultLabel.heightAnchor.constraint(equalToConstant:
            80).isActive = true
        resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32.0).isActive = true
        resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32.0).isActive = true

        pickerView.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 16.0).isActive = true
        pickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pickerView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        pickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32.0).isActive = true
        pickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32.0).isActive = true
    }


    //MARK: - Handlers
    @objc func subjectHandler() {
        pickerView.isHidden = false
    }

    //MARK:- UIPickerViewDataSource
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return subjects.count
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return subjects[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        subjectButton.setTitle(subjects[row], for: .normal)
        pickerView.isHidden = true
    }
}

