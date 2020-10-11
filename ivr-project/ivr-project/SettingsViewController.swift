//
//  SettingsViewController.swift
//  ivr-project
//
//  Created by Ирина Ким on 26.09.2020.
//  Copyright © 2020 Kim Irina. All rights reserved.
//
//kjkk
import Foundation
import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let cellsNames = ["🔔 Уведомления", "📚 Виджет", "👮🏼‍♀️ Профиль", "📧 Обратная связь", "❌ Выход"]
    let cellHeight: CGFloat = 40

    let settingCellId = String(describing: SettingsCell.self)

    let tableView: UITableView = {
        let table = UITableView()
        table.isScrollEnabled = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)

        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(SettingsCell.self, forCellReuseIdentifier: settingCellId)
        navigationItem.title = "Настройки"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupUI()
    }

    private func setupUI() {
        tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: cellHeight*CGFloat(cellsNames.count) - 2).isActive = true
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsNames.count
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: settingCellId, for: indexPath) as! SettingsCell
        cell.textLabel!.text = cellsNames[indexPath.row]
        if cellsNames[indexPath.row] == "❌ Выход" {
            cell.textLabel?.textColor = .red
            cell.textLabel?.textAlignment = .center
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if cellsNames[indexPath.row] == "❌ Выход" {
            dismiss(animated: true, completion: nil)
        }
    }

}



