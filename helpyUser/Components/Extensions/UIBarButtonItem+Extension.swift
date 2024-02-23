//
//  UIBarButtonItem+Extension.swift
//  helpyUser
//
//  Created by mac on 26/05/21.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    func setNavigationBarButtonItemFrame() {
        self.customView?.translatesAutoresizingMaskIntoConstraints = false
        self.customView?.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.customView?.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
}
