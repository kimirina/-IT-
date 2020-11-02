//
//  SettingSection.swift
//  ivr-project
//
//  Created by Ирина Ким on 27.09.2020.
//  Copyright © 2020 Kim Irina. All rights reserved.
//

enum SettingsSection: Int, CaseIterable, CustomStringConvertible  {
    case Profile 
    case Notifications
    
    var description: String {
        switch self {
        case .Notifications: return "Уведомления"
        case .Profile: return "Профиль"
        }
    }
}
