//
//  UIViewController+Extention.swift
//  Helpy
//
//  Created by mac on 26/11/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import  UIKit

extension UIViewController{
    func setGradient_Nav(){
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barTintColor = UIColor.clear
//        let colorTop =  UIColor.App_DarkBlue?.cgColor
//        let colorBottom = UIColor.App_LightBlue?.cgColor
//        self.navigationController?.navigationBar.setGradientBackground(colors: [colorTop!,colorBottom!])
        let image = UserDefaults.standard.data(forKey: "GradientImage") ?? Data()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(data: image), for: .default)
    }
    
    func setUpBackButton() {
        let btnback = UIBarButtonItem(image: UIImage(named: ImageName.back), style: .plain, target: self, action: #selector(btnBackTapped(sender:)))
        self.navigationItem.leftBarButtonItem  = btnback
        enableOrDisableSwipeToGoBack()
    }
    
    func enableOrDisableSwipeToGoBack(_ enable: Bool = true) {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = enable ? self : nil
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = enable ? true : false
    }
    
    func Set_navigationBar(Title:String, isneedback: Bool? = false) {
        self.navigationItem.title = Title
        if (isneedback == true) {
            setUpBackButton()
        } else {
            print("no need to Back button")
        }
    }
    func Set_WhitenavigationBar(Title:String, isneedback: Bool? = false) {
        self.navigationItem.title = Title
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "whitenav"), for: .default)
        if(isneedback == true){
            let btnback = UIBarButtonItem(image: UIImage(named: ImageName.black_back), style: .plain, target: self, action: #selector(btnBackTapped(sender:)))
            self.navigationItem.leftBarButtonItem  = btnback
        }else{
            print("no need to Back button")
        }
    }
    func setGradient_WhiteNav() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "whitenav"), for: .default)
    }
    @objc func btnBackTapped(sender: UIBarButtonItem){
        navigationController?.popViewController(animated: true)
    }
    
    class public var storyboardID: String {
        return "\(self)"
    }
    
    static public func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
    
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func topMostViewController() -> UIViewController? {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
           return topController
        }
        return nil
    }
    
}


extension UIViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
