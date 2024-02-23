//
//  NetworkStatus.swift
//  Sleepbot
//
//

import Foundation
import Alamofire
import UIKit
class NetworkStatus {
    
    //MARK:-Properties
    static let shared = NetworkStatus()
    var isConnected: Bool = false
    let alertWindow: UIWindow = UIWindow(frame: UIScreen.main.bounds)
    private init() {
        
    }
    func showMessageAlert(title: String, andMessage message: String, withOkButtonTitle okButtonTitle: String = "OK") {
         //  let alertWindow: UIWindow = UIWindow(frame: UIScreen.main.bounds)
           alertWindow.rootViewController = UIViewController()
           alertWindow.windowLevel = UIWindow.Level.alert + 1
           alertWindow.makeKeyAndVisible()
           let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
           alertWindow.rootViewController?.present(alertController, animated: true, completion: nil)
       }
    
    let reachabilityManager = NetworkReachabilityManager()
    
    func startNetworkReachabilityObserver() {
        reachabilityManager?.startListening { status in
            print("Network Status Changed: \(status)")
            switch status {
            case .notReachable:
                print("The network is not reachable")
                self.showMessageAlert(title: "Helpy", andMessage: "The network is not reachable")
                self.isConnected = false
            case .unknown :
                print("It is unknown whether the network is reachable")
                self.showMessageAlert(title: "Helpy", andMessage: "It is unknown whether the network is reachable")
                self.isConnected = true
            case .reachable(.ethernetOrWiFi):
                print("The network is reachable over the WiFi connection")
                self.alertWindow.isHidden = true
                self.isConnected = true
//                self.callAPIOnInternetConnection(name: self.lastAPIAndParams)
            case .reachable(.cellular):
                print("The network is reachable over the cellular connection")
                self.alertWindow.isHidden = true
                self.isConnected = true
//                self.callAPIOnInternetConnection(name: self.lastAPIAndParams)
            }
        }
    }
    
//    func callAPIOnInternetConnection(name : APIAndParams){
//        switch name.APIName {
//        case .gethorseList:
//            NetworkManager.share.getHorseList { (response) in
//                switch response {
//                case .success(let resData):
//                    print(resData)
//                    break
//                case.failure(let error):
//                    print(error)
//                    break
//                }
//            }
//            break
//        default:
//            break
//        }
//    }
    
}
