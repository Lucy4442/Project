//
//  String+Extension.swift
//  HelpyService
//
//  Created by mac on 17/11/21.
//  Copyright © 2021 mac. All rights reserved.
//

import Foundation

extension String {
    
    func trim() -> String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
    
}

extension Optional {
    func asStringOrEmpty() -> String {
        switch self {
        case .some(let value):
            return String(describing: value)
        case _:
            return ""
        }
    }
}
