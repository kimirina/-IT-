//
//  WeightTextFeild.swift
//  ivr-project
//
//  Created by Kim Irina on 05.11.2020.
//  Copyright © 2020 Kim Irina. All rights reserved.
//

import UIKit

class WeightTextFeild: UITextField, UITextFieldDelegate {

    override func layoutSubviews() {
        super.layoutSubviews()
        delegate = self
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return ["","0","1","2","3","4", "5", "6", "7", "8", "9", "."].contains(string) && range.location <= 3
    }
}

