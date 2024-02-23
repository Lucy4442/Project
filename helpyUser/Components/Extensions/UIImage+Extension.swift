//
//  UIImage+Extension.swift
//  HelpyService
//
//  Created by mac on 19/04/21.
//  Copyright © 2021 mac. All rights reserved.
//

import Foundation
import SDWebImage
import  UIKit

extension UIImageView {
    func getImage(url: String, placeholderImage: String) {
        let Image = UIImage(named: placeholderImage)
        self.sd_imageIndicator?.startAnimatingIndicator()
        self.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.sd_setImage(with: URL(string: url), placeholderImage:  Image, options: SDWebImageOptions(rawValue: 0), completed: { image, error, cacheType, imageURL in
            if error == nil {
                self.image = image
                self.sd_imageIndicator?.stopAnimatingIndicator()
                self.sd_imageIndicator = nil
            }else {
                self.sd_imageIndicator?.stopAnimatingIndicator()
                self.sd_imageIndicator = nil
            }
        })
    }
}
