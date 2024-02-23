//
//  Call.swift
//  HelpyService
//
//  Created by mac on 24/11/21.
//  Copyright © 2021 mac. All rights reserved.
//

import UIKit

struct CallUtil {
    
    @discardableResult
    static func call(_ number: String) -> Bool {
        if let url = URL(string: "tel://\(number)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
            return true
        }
        return false
    }
    
}
