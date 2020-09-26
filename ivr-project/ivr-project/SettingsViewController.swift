//
//  SettingsViewController.swift
//  ivr-project
//
//  Created by Ирина Ким on 26.09.2020.
//  Copyright © 2020 Kim Irina. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    
}
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return SettingsSection.allCases.count
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 2
        case 1: return 3
        default: return 0
        }
    }
    
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let view = UIView()
            view.backgroundColor = .white
            
            let label = UILabel()
            label.text = SettingsSection(rawValue: section)?.description
            label.textColor = UIColor(red: 0.17, green: 0.18, blue: 0.26, alpha: 1.0)
            label.font = UIFont.boldSystemFont(ofSize: 30.0)
            view.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
            
            return view
        }
        
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 40
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SettingsCell
        return cell
    }
}

