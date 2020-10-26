//
//  ViewController.swift
//  ivr-project
//
//  Created by Ирина Ким on 07.09.2020.
//  Copyright © 2020 Kim Irina. All rights reserved.
//

import Foundation
import UIKit
//import SwiftEntryKit

class LoginViewController: UIViewController {

    var isVuzControllerEnabler: Bool = true

    lazy var appNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Дневник+"
        label.textColor = UIColor(red: 0.17, green: 0.18, blue: 0.26, alpha: 1.0)
        label.font = UIFont.boldSystemFont(ofSize: 30.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var nextVCButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Калькулятор", for: .normal)
        button.setTitleColor(.init(red: 1, green: 1, blue: 1, alpha: 1.0), for: .normal)
        button.backgroundColor = UIColor(red: 0.85, green: 0.0, blue: 0.2, alpha: 1)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(showSecondVC), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var segmentedController: UISegmentedControl = {
        let segmentedcontroller = UISegmentedControl(items:["Ученик", "Ученик лицея"])
        segmentedcontroller.backgroundColor = .init(red: 0.85, green: 0.0, blue: 0.2, alpha: 1)
        segmentedcontroller.addTarget(self, action: #selector(segmentControllerHandler), for: .valueChanged)
        segmentedcontroller.selectedSegmentIndex = 0
        segmentedcontroller.translatesAutoresizingMaskIntoConstraints = false
        return segmentedcontroller
    }()
    
    lazy var inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.backgroundColor = .init(red: 0.55, green: 0.6, blue: 0.68, alpha: 0.2)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy var logInTextField: UITextField = {
        let textField = UITextField()
        //      textField.backgroundColor = .init(red: 0.55, green: 0.6, blue: 0.68, alpha: 0.2)
        textField.layer.cornerRadius = 10
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Login"
        textField.text = "kimirina"
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        //      textField.backgroundColor = .init(red: 0.55, green: 0.6, blue: 0.68, alpha: 0.2)
        textField.layer.cornerRadius = 10
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.text = "Irina04112002"
        return textField
    }()
    

    //MARK: - Handlers
    @objc func segmentControllerHandler() {
        switch segmentedController.selectedSegmentIndex {
        case 0:
            thirdVCButtonTopAnchor?.isActive = false
            thirdVCButtonTopAnchor = nextVCButton.topAnchor.constraint(equalTo: segmentedController.bottomAnchor, constant: 16.0)
            thirdVCButtonTopAnchor?.isActive = true
        
            nextVCButton.setTitle("Калькулятор", for: .normal)
            hideInputViewController()
        case 1:
            thirdVCButtonTopAnchor?.isActive = false
            thirdVCButtonTopAnchor = nextVCButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 16.0)
            thirdVCButtonTopAnchor?.isActive = true
            
            nextVCButton.setTitle("Войти", for: .normal)
            showInputViewController()
        default :
            break
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

    @objc func showSecondVC() {
        switch segmentedController.selectedSegmentIndex {
        case 0:
            showCalculaterViewController()
        case 1:
            showTabBarController()
        default:
            break
        }
    }
    
    
    private var thirdVCButtonTopAnchor: NSLayoutConstraint?
    
    private func hideInputViewController() {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.inputsContainerView.alpha = 0
            self.logInTextField.alpha = 0
            self.passwordTextField.alpha = 0
        }, completion: { _ in
            self.inputsContainerView.isHidden = true
            self.logInTextField.isHidden = true
            self.passwordTextField.isHidden = true
        })
        
    }
    
    private func showInputViewController() {
        UIView.animate(withDuration: 0.3, animations: {
            self.inputsContainerView.isHidden = false
            self.logInTextField.isHidden = false
            self.passwordTextField.isHidden = false
            
            self.inputsContainerView.alpha = 1
            self.logInTextField.alpha = 1
            self.passwordTextField.alpha = 1
        })
    }
    
    
    private func setupUI() {
        
        view.backgroundColor = UIColor(red: 0.93, green: 0.95, blue: 0.96, alpha: 1.0)
        inputsContainerView.addSubview(logInTextField)
        inputsContainerView.addSubview(passwordTextField)
        hideInputViewController()
        
        //Label
        appNameLabel.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 128.0).isActive = true
        appNameLabel.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        appNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32.0).isActive = true
        
        //Segment Control
        segmentedController.topAnchor.constraint(lessThanOrEqualTo: appNameLabel.bottomAnchor, constant: 16).isActive = true
        segmentedController.heightAnchor.constraint(equalToConstant: 45.0).isActive = true
        segmentedController.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32.0).isActive = true
        segmentedController.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32.0).isActive = true
        
        
        //Inputs container
        inputsContainerView.topAnchor.constraint(equalTo: segmentedController.bottomAnchor, constant: 8.0).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        inputsContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32.0).isActive = true
        inputsContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32.0).isActive = true
        
        //log in text field
        logInTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: 0.0).isActive = true
        logInTextField.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        logInTextField.leadingAnchor.constraint(equalTo: inputsContainerView.leadingAnchor, constant: 8.0).isActive = true
        logInTextField.trailingAnchor.constraint(equalTo: inputsContainerView.trailingAnchor, constant: -8.0).isActive = true
        
        //password text field
        passwordTextField.topAnchor.constraint(equalTo: logInTextField.bottomAnchor, constant: 8.0).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: inputsContainerView.leadingAnchor, constant: 8.0).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: inputsContainerView.trailingAnchor, constant: -8.0).isActive = true
        
        //Button ThirdVC ОШИБКА
        nextVCButton.heightAnchor.constraint(equalToConstant: 45.0).isActive = true
        nextVCButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32.0).isActive = true
        nextVCButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32.0).isActive = true
        thirdVCButtonTopAnchor = nextVCButton.topAnchor.constraint(equalTo: segmentedController.bottomAnchor, constant: 16.0)
        thirdVCButtonTopAnchor?.isActive = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(appNameLabel)
        view.addSubview(segmentedController)
        view.addSubview(nextVCButton)
        view.addSubview(inputsContainerView)

        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }

    private func showCalculaterViewController() {
        let nextVC = CalculatorViewController()
        nextVC.modalPresentationStyle = .fullScreen
        present(nextVC, animated: true)
    }


    private func showTabBarController() {

        guard
            let login = logInTextField.text,
            let password = passwordTextField.text
        else { return }

        NetworkSerivce.logIn(
            login: login,
            password: password,
            completionHandler: { result in
                switch result {
                case .success(let token):
                    NetworkSerivce.auth_token = token
                    NetworkSerivce.getStudentId(completionHandler: { result in
                        switch result {
                        case .success(let id):
                            print("студент айди", id)
                            DispatchQueue.main.async {
                                let nextVC = self.setupTabBarController()
                                nextVC.modalPresentationStyle = .fullScreen
                                self.present(nextVC, animated: true, completion: nil)
                            }
                        case .failure(let error):
                            print(error)
                        }
                    })


                case .failure:
                    let alert = UIAlertController(title: "Error", message: "Ошибка аутентификации", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                    DispatchQueue.main.async {
                        self.present(alert, animated: true, completion: nil)
                    }
                }
        })
    }



    private func setupTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .init(red: 0.85, green: 0.0, blue: 0.2, alpha: 1)
        
        
        let calculateImage = UIImage(systemName: "plus.slash.minus", withConfiguration: UIImage.SymbolConfiguration(weight: .medium))?.withTintColor(.systemRed, renderingMode: .automatic)
        let scheduleImage = UIImage(systemName: "list.dash", withConfiguration: UIImage.SymbolConfiguration(weight: .medium))?.withTintColor(.systemRed, renderingMode: .automatic)
        let settingsImage = UIImage(systemName: "gear", withConfiguration: UIImage.SymbolConfiguration(weight: .medium))?.withTintColor(.systemRed, renderingMode: .automatic)
        let vuzImage = UIImage(systemName: "house.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemRed, renderingMode: .automatic)
        let scheduleBarButton = UITabBarItem(title: "Расписание", image: scheduleImage, tag: 0)
        let calculateBarBytton = UITabBarItem(title: "Открыть калькулятор", image: calculateImage, tag: 1)
        let settingBarButton = UITabBarItem(title: "Настройки", image: settingsImage, tag: 2)

        let vuzBarButton = UITabBarItem(title: "ВУЗы", image: vuzImage, tag: 3)

        let scheduleVC = ScheduleTableViewController()
        scheduleVC.tableView.frame = UIScreen.main.bounds
        scheduleVC.tableView.backgroundColor = .init(red: 0.93, green: 0.95, blue: 0.96, alpha: 1.0)
        scheduleVC.tabBarItem = scheduleBarButton
        let scheduleNavigationController = UINavigationController(rootViewController: scheduleVC)
        
        let calculateVC =  CalculatorViewController()
        calculateVC.view.frame = UIScreen.main.bounds
        calculateVC.tabBarItem = calculateBarBytton

        let settingsVC = SettingsViewController()
        settingsVC.view.frame = UIScreen.main.bounds
        settingsVC.view.backgroundColor = .init(red: 0.93, green: 0.95, blue: 0.96, alpha: 1.0)
        settingsVC.tabBarItem = settingBarButton
        let settingsNavigationController = UINavigationController(rootViewController: settingsVC)

        if isVuzControllerEnabler {
            let vuzController = UIViewController()
            vuzController.tabBarItem = vuzBarButton
            tabBarController.viewControllers = [scheduleNavigationController, calculateVC, vuzController, settingsNavigationController]
        } else {
            tabBarController.viewControllers = [scheduleVC, calculateVC, settingsNavigationController]
        }
        
        return tabBarController
    }
    
}






