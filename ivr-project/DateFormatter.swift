//
//  DateFormatter.swift
//  ivr-project
//
//  Created by Ким Ирина on 21.10.2020.
//  Copyright © 2020 Kim Irina. All rights reserved.
//

import Foundation

extension DateFormatter {

    enum DateIntreval {
        case week
        case halfYear
    }
//31622400
    static let secondsInWeek: TimeInterval = 604800
    static let secondsInHalfYear: TimeInterval = 31622400

    static func getEljurDate(currentDate: Date, timeInterval: DateIntreval = .week) -> String {

        var seconds: TimeInterval
        switch timeInterval {
        case .week:
            seconds = secondsInWeek
        case .halfYear:
            seconds = secondsInHalfYear
        }

        let afterOneWeekDate = currentDate.addingTimeInterval(seconds)
        let formater = DateFormatter()
        formater.dateFormat = "YYYYMMdd"
        return "\(formater.string(from: currentDate))-\(formater.string(from: afterOneWeekDate))"
    }

    static func getWeekDate(after n: Int) -> Date {
        let currentDate = Date()
        let startAfterNWeeksDate = currentDate.addingTimeInterval(TimeInterval(Int(secondsInWeek) * n))
        return startAfterNWeeksDate
    }

    static func getTimeIntervalSince1970(date: String) -> TimeInterval {
        let formater = DateFormatter()
        formater.dateFormat = "YYYYMMdd"
        guard let date = formater.date(from: date) else {
            return TimeInterval()
        }
        return date.timeIntervalSince1970
    }

    static func getTimeInViewFormat(date: String) -> String {
        let formater = DateFormatter()
        formater.dateFormat = "YYYYMMdd"
        guard let date = formater.date(from: date) else {
            return ""
        }

        formater.dateFormat = "d MMMM yyyy"
        return formater.string(from: date)
    }
}


