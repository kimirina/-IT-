//
//  ScheduleTableViewCell.swift
//  ivr-project
//
//  Created by Игорь Шамрин on 28.10.2020.
//  Copyright © 2020 Kim Irina. All rights reserved.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {
	@IBOutlet var subjectLabel: UILabel!
	@IBOutlet var numLabel: UILabel!
	@IBOutlet var teacherLabel: UILabel!
	@IBOutlet var roomLabel: UILabel!
	@IBOutlet var startTimeLabel: UILabel!
	@IBOutlet var endTimeLabel: UILabel!

	override func layoutSubviews() {
		subjectLabel.sizeToFit()
		numLabel.sizeToFit()
		teacherLabel.sizeToFit()
		roomLabel.sizeToFit()
		startTimeLabel.sizeToFit()
		endTimeLabel.sizeToFit()

		let subjectWidth = startTimeLabel.frame.minX - numLabel.frame.maxX - 16.0
//		subjectLabel.frame = CGRect(x: subjectLabel.frame.origin.x, y: subjectLabel.frame.origin.y, width: subjectWidth, height: subjectLabel.frame.height)
	}

	func setCell(schoolClass: SchoolClass) {
		subjectLabel.text = schoolClass.name
		numLabel.text = schoolClass.num
		teacherLabel.text = schoolClass.teacher
		roomLabel.text = schoolClass.room
		startTimeLabel.text = schoolClass.starttime
		endTimeLabel.text = schoolClass.endtime
	}
}
