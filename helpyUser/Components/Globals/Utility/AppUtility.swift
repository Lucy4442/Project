//
//  AppUtility.swift
//  Helpy
//
//  Created by mac on 09/11/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class AppUtility: NSObject {
    static let shared = AppUtility()
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    class func alertMessage(_ message: String, viewcontroller: UIViewController){
        let alert = UIAlertController(title: "Helpy", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
        let sceneDelegate = UIApplication.shared.delegate as! AppDelegate
        sceneDelegate.window!.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    class func alertMessage(_ message: String, viewcontroller: UIViewController, okAction: ((UIAlertAction) -> Void)? = nil, cancelAction: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: "Helpy", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: okAction))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: cancelAction))
        let sceneDelegate = UIApplication.shared.delegate as! AppDelegate
        sceneDelegate.window!.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
   class  func SetupHeaderview(Frame: CGRect, Headername : String)-> UIView{
        let HeaderView = UIView(frame: Frame)
        HeaderView.backgroundColor = .white
    let BtnArrow  = UIButton(frame: CGRect(x: 20, y: 15, width: 15 ,height: 15))
        BtnArrow.setImage(UIImage(named: ImageName.Arrow), for: .normal)
    let Lbltitle = UILabel(frame: CGRect(x: 40, y: 10, width: HeaderView.frame.size.width / 2, height: HeaderView.frame.size.height / 2))
    Lbltitle.text = Headername
    Lbltitle.font = UIFont(name: "System", size: 12)
    Lbltitle.textColor = .black
        
        HeaderView.addSubview(BtnArrow)
        HeaderView.addSubview(Lbltitle)
        return HeaderView
    }
    class func appDelegate() -> AppDelegate {
        return self.shared.appDelegate
    }
    class func windowMain() -> UIWindow? {
        return self.appDelegate().window
    }
}
