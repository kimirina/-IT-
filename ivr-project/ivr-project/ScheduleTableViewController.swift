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

    var week = 0
    private func getSchedule(_ studentId: String, atWeek: Int) {

        let group = DispatchGroup()
        DispatchQueue.global().async(group: group) {
            group.enter()
            NetworkSerivce.schedule(
                studentId: studentId,
                days: DateFormatter.getWeek(currentDate: DateFormatter.getWeekDate(after: atWeek)),
                rings: "yes",
                completionHandler: { result in
                    switch result {
                    case .success(let schedule):
                        var schoolDays = schedule
                        for i in 0..<schoolDays.count {
                            schoolDays[i].items?.sort { Int($0.num!)! < Int($1.num!)! }
                        }
                        schoolDays.sort { DateFormatter.getTimeIntervalSince1970(date: $0.name!) < DateFormatter.getTimeIntervalSince1970(date: $1.name!) }
                        DispatchQueue.main.async {
                            self.schoolDays += schoolDays
                        }
                    case .failure(let error):
                        print(error)
                    }
                    group.leave()
            }
            )
        }
        group.wait()
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        navigationItem.title = "Расписание"
        navigationController?.navigationBar.prefersLargeTitles = true
        

        guard let studentId = NetworkSerivce.studentId else {
            print("Не удалось получить id студента")
            return
        }

        getSchedule(studentId, atWeek: week)
        week += 1
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
        let date = DateFormatter.getTimeInViewFormat(date: schoolDays[section].name!)
        label.text = schoolDays[section].title! + ": " + date
        label.sizeToFit()
        return label
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell")
        cell?.textLabel?.text = schoolDays[indexPath.section].items![indexPath.row].name
        return cell!
    }

    //MARK: Обработка конца скролла
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            guard let studentId = NetworkSerivce.studentId else {
                print("Не удалось получить id студента")
                return
            }
            getSchedule(studentId, atWeek: week)
            week += 1
        }
    }

}


