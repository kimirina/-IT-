//
//  Subjects.swift
//  ivr-project
//
//  Created by Kim Irina on 04.10.2020.
//  Copyright © 2020 Kim Irina. All rights reserved.
//

import UIKit
import PanModal

class SubjectsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let subjects = ["Математика", "Физика", "Русский", "Биология"]

    var calculaterViewController: CalculatorViewController?

    let tableView: UITableView = {
        let table = UITableView(frame: UIScreen.main.bounds)
        return table
    }()

    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tableCell123")
        view.addSubview(tableView)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel!.text = subjects[indexPath.row]
        cell.textLabel!.textAlignment = .center
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        calculaterViewController?.subjectButton.setTitle(subjects[indexPath.row], for: .normal)
        tableView.deselectRow(at: indexPath, animated: true)
        dismiss(animated: true, completion: nil)
    }

}

extension SubjectsTableViewController: PanModalPresentable {
    
    var panScrollable: UIScrollView? {
        return nil
    }

    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(400)
    }

    var anchorModalToLongForm: Bool {
        return false
    }

}



