//
//  SchoolDay.swift
//  ivr-project
//
//  Created by Kim Irina on 17.10.2020.
//  Copyright © 2020 Kim Irina. All rights reserved.
//

import Foundation

struct SchoolDay: Codable {
    var name: String?
    var title: String?
    var items: [SchoolClass]?
}

