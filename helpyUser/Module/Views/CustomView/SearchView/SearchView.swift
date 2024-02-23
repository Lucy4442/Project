//
//  SearchView.swift
//  helpyUser
//
//  Created by mac on 01/02/21.
//

import UIKit

class SearchView: UIView {
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    class func instanceFromNib() -> SearchView {
            return UINib(nibName: "SearchView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! SearchView
        }
}
