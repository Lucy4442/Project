//
//  UINavigation+Extention.swift
//  Helpy
//
//  Created by mac on 25/11/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit
extension UINavigationBar {
    func setGradientBackground(colors: [CGColor]) {
        self.isTranslucent = false
        let gradientLayer = CAGradientLayer()
        var updatedFrame = self.bounds
        var statusBarHeight : CGFloat = 0.0
      //  if #available(iOS 14.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            statusBarHeight = window?.safeAreaInsets.top ?? 0
      //  }
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        }
        else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        if #available(iOS 14.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            statusBarHeight = window?.safeAreaInsets.top ?? 0
        }
        
        updatedFrame.size.height += statusBarHeight
        gradientLayer.frame = updatedFrame
        gradientLayer.colors = colors
        gradientLayer.locations = [0.0,1.0]
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        let Gimage = image?.jpegData(compressionQuality: 0.1) ?? Data()
        UserDefaults.standard.set(Gimage, forKey: "GradientImage")
        UIGraphicsEndImageContext()
        self.frame = updatedFrame
        self.setBackgroundImage(image, for: UIBarMetrics.default)
    }
    
}
