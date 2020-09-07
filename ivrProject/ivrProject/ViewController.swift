//
//  ViewController.swift
//  ivrProject
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
    
    lazy var pupilButton: UIButton = {
        let pupil = UIButton(type: .system)
        pupil.setTitle("Ученик", for: .normal)
        pupil.setTitleColor(.init(red: 1, green: 1, blue: 1, alpha: 1.0), for: .normal)
        pupil.backgroundColor = UIColor(red: 0.85, green: 0.0, blue: 0.2, alpha: 1.0)
        pupil.layer.cornerRadius = 10
        pupil.translatesAutoresizingMaskIntoConstraints = false
        return pupil
    }()
    
    lazy var lycPupilButton: UIButton = {
        let lycPupil = UIButton(type: .system)
        lycPupil.setTitle("Ученик лицея", for: .normal)
        lycPupil.setTitleColor(.init(red: 1, green: 1, blue: 1, alpha: 1.0), for: .normal)
        lycPupil.backgroundColor = UIColor(red: 0.85, green: 0.0, blue: 0.2, alpha: 1.0)
        lycPupil.layer.cornerRadius = 10
        lycPupil.translatesAutoresizingMaskIntoConstraints = false
        lycPupil.addTarget(self, action: #selector(showSecondVC), for: .touchUpInside)
        return lycPupil
    }()
    
    func setupUI() {
        
        view.backgroundColor = UIColor(red: 0.93, green: 0.95, blue: 0.96, alpha: 1.0)
        
        //Label
        appNameLabel.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 128.0).isActive = true
        appNameLabel.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        appNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32.0).isActive = true
        
        
        //PupilButton
        pupilButton.topAnchor.constraint(greaterThanOrEqualTo: appNameLabel.bottomAnchor, constant: 8.0) .isActive = true
        pupilButton.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        pupilButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32.0).isActive = true
        pupilButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32.0).isActive = true
        
        //LyceumPupilButton
        lycPupilButton.topAnchor.constraint(greaterThanOrEqualTo: pupilButton.bottomAnchor, constant: 4.0).isActive = true
        lycPupilButton.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        lycPupilButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32.0).isActive = true
         lycPupilButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32.0).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(appNameLabel)
        view.addSubview(pupilButton)
        view.addSubview(lycPupilButton)

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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Переход на 2 контроллер" {
            if let secondVC = segue.destination as? SecondViewController {
                secondVC.logInLabel.text = "текст из override func prepare"
            }
        }
    }

}
