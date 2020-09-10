//
//  ViewController.swift
//  ivr-project
//
//  Created by Ирина Ким on 07.09.2020.
//  Copyright © 2020 Kim Irina. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    
    lazy var appNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Дневник+"
        label.textColor = UIColor(red: 0.17, green: 0.18, blue: 0.26, alpha: 1.0)
        label.font = UIFont.boldSystemFont(ofSize: 30.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var thirdVCButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Открыть калькулятор", for: .normal)
        button.setTitleColor(.init(red: 1, green: 1, blue: 1, alpha: 1.0), for: .normal)
        button.backgroundColor = UIColor(red: 0.85, green: 0.0, blue: 0.2, alpha: 1.0)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(showThirdVC), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var segmentedController: UISegmentedControl = {
        let segmentedcontroller = UISegmentedControl(items:["Ученик", "Ученик лицея"])
        segmentedcontroller.backgroundColor = .init(red: 0.85, green: 0.0, blue: 0.2, alpha: 0.95)
        segmentedcontroller.addTarget(self, action: #selector(ViewController.segmentControl(_:)), for: .valueChanged)
        segmentedcontroller.selectedSegmentIndex = 0
        segmentedcontroller.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: "DINCondensed-Bold", size: 18),
            NSAttributedString.Key.foregroundColor: UIColor.lightGray
            ], for: .normal)
        segmentedcontroller.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: "DINCondensed-Bold", size: 18),
            NSAttributedString.Key.foregroundColor: UIColor.red
            ], for: .selected)
        segmentedcontroller.translatesAutoresizingMaskIntoConstraints = false
        return segmentedcontroller
    }()
    
    lazy var logIn: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .init(red: 0.55, green: 0.6, blue: 0.68, alpha: 0.2)
        textField.layer.cornerRadius = 10
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var password: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .init(red: 0.55, green: 0.6, blue: 0.68, alpha: 0.2)
        textField.layer.cornerRadius = 10
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var logInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.init(red: 1, green: 1, blue: 1, alpha: 1.0), for: .normal)
        button.backgroundColor = UIColor(red: 0.85, green: 0.0, blue: 0.2, alpha: 1.0)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(logInButtonPressed), for: .touchUpInside)
        return button
    }()
    
    @objc func segmentControl(_ segmentedControl: UISegmentedControl) {
       switch (segmentedControl.selectedSegmentIndex) {
          case 0:
             // First segment tapped
            view.addSubview(thirdVCButton)
          break
          case 1:
             // Second segment tapped
            //showSecondVC()
            view.addSubview(logIn)
            view.addSubview(logInButton)
            view.addSubview(password)
          break
          default:
          break
       }
    }
    
    @objc func logInButtonPressed() {
            let nextVC = UITabBarController()
            nextVC.tabBar.tintColor = .red
            nextVC.modalPresentationStyle = .fullScreen

            let calculateImage = UIImage(systemName: "plus.slash.minus", withConfiguration: UIImage.SymbolConfiguration(weight: .medium))?.withTintColor(.systemPink, renderingMode: .alwaysOriginal)
            let scheduleImage = UIImage(systemName: "list.dash", withConfiguration: UIImage.SymbolConfiguration(weight: .medium))?.withTintColor(.systemPink, renderingMode: .alwaysOriginal)

            let scheduleBarButton = UITabBarItem(title: "Расписание", image: scheduleImage, tag: 0)
            let calculateBarBytton = UITabBarItem(title: "Калькулятор", image: calculateImage, tag: 1)

            let scheduleVC = UITableViewController()
            scheduleVC.tableView.frame = UIScreen.main.bounds
            scheduleVC.tableView.backgroundColor = .gray
            scheduleVC.tabBarItem = scheduleBarButton

            let calculateVC = UIViewController()
            calculateVC.view.frame = UIScreen.main.bounds
            calculateVC.view.backgroundColor = .red
            calculateVC.tabBarItem = calculateBarBytton

            nextVC.viewControllers = [scheduleVC, calculateVC]

            //1
            present(nextVC, animated: true, completion: nil)
            //2
    //        navigationController?.pushViewController(nextVC, animated: true)
        }
    
    func setupUI() {
        
        view.backgroundColor = UIColor(red: 0.93, green: 0.95, blue: 0.96, alpha: 1.0)
        
        //Label
        appNameLabel.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 128.0).isActive = true
        appNameLabel.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        appNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32.0).isActive = true
        
        //log in text field
//        logIn.topAnchor.constraint(greaterThanOrEqualTo: segmentedController.bottomAnchor, constant: 8.0).isActive = true
//        logIn.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
//        logIn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32.0).isActive = true
//        logIn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32.0).isActive = true
        
        //password text field
        password.topAnchor.constraint(greaterThanOrEqualTo: logIn.bottomAnchor, constant: 8.0).isActive = true
        password.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        password.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32.0).isActive = true
        logIn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32.0).isActive = true
        
        //button
        logInButton.topAnchor.constraint(greaterThanOrEqualTo: password.bottomAnchor, constant: 16.0).isActive = true
        logInButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        logInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32.0).isActive = true
        logInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32.0).isActive = true
        
        
        //Button ThirdVC ОШИБКА
//        thirdVCButton.topAnchor.constraint(lessThanOrEqualTo: segmentedController.bottomAnchor, constant: 16.0).isActive = true
//        thirdVCButton.heightAnchor.constraint(equalToConstant: 45.0).isActive = true
//        thirdVCButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32.0).isActive = true
//        thirdVCButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32.0).isActive = true
        
        //Segment Control
        segmentedController.topAnchor.constraint(lessThanOrEqualTo: appNameLabel.bottomAnchor, constant: 16).isActive = true
        segmentedController.heightAnchor.constraint(equalToConstant: 45.0).isActive = true
        segmentedController.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32.0).isActive = true
        segmentedController.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32.0).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(appNameLabel)
        view.addSubview(segmentedController)
        
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }




    @objc func showSecondVC() {
        let secondViewController = SecondViewController()
        secondViewController.modalPresentationStyle = .fullScreen
//        present(secondViewController, animated: true, completion: nil)
        navigationController?.pushViewController(secondViewController, animated: true)
    }

    @objc func showThirdVC() {
            let thirdViewController = ThirdViewController()
            thirdViewController.modalPresentationStyle = .fullScreen
    //        present(secondViewController, animated: true, completion: nil)
            navigationController?.pushViewController(thirdViewController, animated: true)
        }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Переход на 2 контроллер" {
            if let secondVC = segue.destination as? SecondViewController {
                secondVC.logInLabel.text = "текст из override func prepare"
            }
        }
    }

}

