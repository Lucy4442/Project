//
//  UITableviewCell+Extension.swift
//  Helpy
//
//  Created by mac on 29/12/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    /// Return Nib
    public static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    /// Return Identifier
    public static var identifier: String {
        return String(describing: self)
    }
    
}
extension UITableViewHeaderFooterView {
    /// Return Nib
    public static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    /// Return Identifier
    public static var identifier: String {
        return String(describing: self)
    }
}
