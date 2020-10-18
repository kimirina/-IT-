//
//  ScheduleTableViewController.swift
//  ivr-project
//
//  Created by Kim Irina on 18.10.2020.
//  Copyright © 2020 Kim Irina. All rights reserved.
//

import UIKit

class ScheduleTableViewController: UIViewController {

    let tableView: UITableView = {
        let table = UITableView(frame: UIScreen.main.bounds)
        return table
    }()

    var schoolDays: [SchoolDay] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")

        NetworkSerivce.schedule(
            student: "49177",
            days: "20201016-20201017",
            rings: "yes",
            completionHandler: { result in
                switch result {
                case .success(let schedule):
                    var schoolDays = schedule
                    for i in 0..<schoolDays.count {
                        schoolDays[i].items?.sort { $0.num! < $1.num! }
                    }
                    DispatchQueue.main.async {
                        self.schoolDays = schoolDays
                    }
                case .failure(let error):
                    print(error)
                }
            }
        )
    }
}

extension ScheduleTableViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return schoolDays.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schoolDays[section].items!.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel(frame: .zero)
        label.text = schoolDays[section].title
        label.sizeToFit()
        return label
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell")
        cell?.textLabel?.text = schoolDays[indexPath.section].items![indexPath.row].name
        return cell!
    }

}

