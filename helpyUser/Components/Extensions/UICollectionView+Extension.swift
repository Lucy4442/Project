//
//  UICollectionView+Extension.swift
//  helpyUser
//
//  Created by mac on 05/01/21.
//

import Foundation
import  UIKit

extension UICollectionViewCell {
    /// Return Nib
    public static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    /// Return Identifier
    public static var identifier: String {
        return String(describing: self)
    }
}
class DynamicHeightCollectionView: UICollectionView {
    override func layoutSubviews() {
        super.layoutSubviews()
        if bounds.size != intrinsicContentSize {
            self.invalidateIntrinsicContentSize()
        }
    }
    override var intrinsicContentSize: CGSize {
        return collectionViewLayout.collectionViewContentSize
    }
}
