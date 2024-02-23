//
//  UIFont+Extension.swift
//  helpyUser
//
//  Created by mac on 12/01/21.
//

import Foundation
import  UIKit

extension UIFont{
    
    static let Regular          = UIFont(name: FontName.Poppins_Regular, size: FontSize(size: 42))
    static let Italic           = UIFont(name: FontName.Poppins_Italic, size: FontSize(size: 12))
    
    static let Bold             = UIFont(name: FontName.Poppins_Bold, size: FontSize(size: 12))
    static let Bold_Italic       = UIFont(name: FontName.Poppins_BoldItalic, size: FontSize(size: 12))
    static let Black            = UIFont(name: FontName.Poppins_Black, size: FontSize(size: 12))
    static let Black_Italic      = UIFont(name: FontName.Poppins_BlackItalic, size: FontSize(size: 12))
   
    static let Extra_Bold        = UIFont(name: FontName.Poppins_ExtraBold, size: FontSize(size: 12))
    static let Extra_Bold_Italic  = UIFont(name: FontName.Poppins_ExtraBoldItalic, size: FontSize(size: 12))
    static let Extra_Light       = UIFont(name: FontName.Poppins_ExtraLight, size: FontSize(size: 12))
    static let Extra_Light_Italic = UIFont(name: FontName.Poppins_ExtraLightItalic, size: FontSize(size: 12))
   
    static let Light            = UIFont(name: FontName.Poppins_Light, size: FontSize(size: 12))
    static let Light_Italic      = UIFont(name: FontName.Poppins_LightItalic, size: FontSize(size: 12))
    
    static let Medium           = UIFont(name: FontName.Poppins_Medium, size: FontSize(size: 36))
    static let Medium_Italic     = UIFont(name: FontName.Poppins_MediumItalic, size: FontSize(size: 12))
    
    static let Semi_Bold        = UIFont(name: FontName.Poppins_SemiBold, size: FontSize(size: 42))
    static let Semi_Bold_Italic  = UIFont(name: FontName.Poppins_SemiBoldItalic, size: FontSize(size: 12))
    
    static let Thin            = UIFont(name: FontName.Poppins_Thin, size: FontSize(size: 12))
    static let Thin_Italic      = UIFont(name: FontName.Poppins_ThinItalic, size: FontSize(size: 12))
    
    class func AppFont(Name: String, size: CGFloat) -> UIFont{
        return UIFont(name: Name, size: UIFont.FontSize(size: size)) ?? .systemFont(ofSize: UIFont.FontSize(size: size))
    }
    
    
    class func FontSize(size : CGFloat)-> CGFloat{
        let Device = UIScreen.main.bounds.height
        let newSize = ((Device * size)/1920)
        return newSize
    }
}

