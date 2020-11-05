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

    let subjects = NetworkSerivce.subjects
    let marks = NetworkSerivce.marks
    let cellID = "tableCell123"

    var calculaterViewController: CalculatorViewController?

    let tableView: UITableView = {
        let table = UITableView(frame: UIScreen.main.bounds)
//        table.frame.size.height -= 300
        return table
    }()

    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        view.addSubview(tableView)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel!.text = subjects[indexPath.row]
        cell.textLabel!.textAlignment = .center
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let subject = subjects[indexPath.row]
        calculaterViewController?.subjectButton.setTitle(subject, for: .normal)
        guard let subjetcMarks = marks["\(subject)"] else {
            tableView.deselectRow(at: indexPath, animated: true)
            dismiss(animated: true, completion: nil)
            return
        }
        calculaterViewController?.subjectMarks = subjetcMarks
        let marksString = subjetcMarks.reduce("") {
            guard let value = $1.value else {
                return $0
            }
            return $0 + " " + value
        }
        calculaterViewController?.marksTextField.text = marksString
        tableView.deselectRow(at: indexPath, animated: true)
        dismiss(animated: true, completion: nil)
    }

}

extension SubjectsTableViewController: PanModalPresentable {
    
    var panScrollable: UIScrollView? {
        return nil
    }

    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(50)
    }

    var anchorModalToLongForm: Bool {
        return true
    }

}





