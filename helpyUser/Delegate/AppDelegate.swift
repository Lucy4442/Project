//
//  AppDelegate.swift
//  helpyUser
//
//  Created by mac on 31/12/20.
//

import UIKit
import IQKeyboardManagerSwift
import FBSDKLoginKit
import GoogleSignIn
import Firebase
import GoogleMaps
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let NotificationCenter  = UNUserNotificationCenter.current()
    var isSetNavigationBar:Bool = true
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.disabledDistanceHandlingClasses = [OrderDetailViewController.self,OTPViewController.self]
//        GMSServices.provideAPIKey("AIzaSyBtPh2AHw6UB9VMebugc8w2nCco41uGQK4")
        GMSServices.provideAPIKey("AIzaSyCTwoBNkSrfPFsOWeV_00Jb6iZ3qPvu6K0")
        NetworkStatus.shared.startNetworkReachabilityObserver()
        FirebaseApp.configure()
        requestPushNotificationPermissions()
        if #available(iOS 10.0, *) {
            NotificationCenter.delegate = self
            NotificationCenter.requestAuthorization(options: [.badge, .alert, .sound]) {
                (granted, error) in
                if granted {
                    DispatchQueue.main.async {
                        application.registerForRemoteNotifications()
                    }
                } else {
                    print("APNS Registration failed")
                }
            }
        } else {
            let type: UIUserNotificationType = [UIUserNotificationType.badge, UIUserNotificationType.alert, UIUserNotificationType.sound]
            let setting = UIUserNotificationSettings(types: type, categories: nil)
            application.registerUserNotificationSettings(setting)
            application.registerForRemoteNotifications()
        }
        if getBoolUserDefaultValue(key: .isUserLogin) == true{
            self.window = UIWindow(frame: UIScreen.main.bounds)
            
            if (UserDefaultStore.value(key: .isProfileComplated) ?? false) {
                let HomeVC = UserHomeViewController.instantiate(fromAppStoryboard: .User)
                let navigationController =  UINavigationController.init(rootViewController: HomeVC)
                self.window?.rootViewController = navigationController
            } else {
                let loggedInUser = UserDefaultManager.share.getModelDataFromUserDefults(userData: LoggedInUser.self, key: .LoggedInUser)
                let ProfileVc = ProfileViewController.instantiate(fromAppStoryboard: .Menu)
                ProfileVc.isBackBarButtonHidden = true
                ProfileVc.socialID = (loggedInUser?.socialID).asStringOrEmpty()
                if !(loggedInUser?.socialID).asStringOrEmpty().isEmpty {
                    ProfileVc.isupdateprofile = true
                }
                ProfileVc.loginType = (loggedInUser?.loginType).asStringOrEmpty()
                let navigationController =  UINavigationController.init(rootViewController: ProfileVc)
                self.window?.rootViewController = navigationController
            }
        }else{
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let LoginVC = LoginViewController.instantiate(fromAppStoryboard: .Main)
            let navigationController =  UINavigationController.init(rootViewController: LoginVC)
            self.window?.rootViewController = navigationController
        }
        if #available(iOS 13.0, *) { window?.overrideUserInterfaceStyle = .light }
        
       // Auth.auth().languageCode = "IN"
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        // Initialize Google sign-in
//        GIDSignIn.sharedInstance().clientID = "491138335143-nhlo83h80ina9muc8i2tncq12h1a9pki.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().clientID = "903701470347-adttp6ptjj6sovbh4g4joci4q5vhfc1r.apps.googleusercontent.com"
        //GIDSignIn.sharedInstance().delegate = self
        
        // If user already sign in, restore sign-in state.
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        configureNavigationBar()
        return true
    }
    
    func configureNavigationBar() {
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.clear
            let image = UserDefaults.standard.data(forKey: "GradientImage") ?? Data()
            appearance.titleTextAttributes = [.foregroundColor: UIColor.clear]
            appearance.backgroundImage = UIImage(data: image)
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
//        ApplicationDelegate.shared.application(
//            app,
//            open: url,
//            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
//            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
//        )
//        return GIDSignIn.sharedInstance().handle(url)

        return Auth.auth().canHandle(url)
    }
    
    
}
extension AppDelegate : MessagingDelegate{
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase didReceiveRegistrationToken: \(fcmToken ?? "")")
        if getBoolUserDefaultValue(key: .isUserLogin) == true{
            APIManager.share.AddfcmTokenData(device_token: fcmToken ?? "") { (Result) in
                switch Result{
                case .success(let response):
                    print(response)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func requestPushNotificationPermissions() {
        Messaging.messaging().delegate = self
        Messaging.messaging().isAutoInitEnabled = true
    }
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            print("Notification settings: \(settings)")
        }
    }
    
    func application(application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("Device Token: \(deviceToken)")
        //          Messaging.messaging().apnsToken = deviceToken
        Auth.auth().setAPNSToken(deviceToken, type: .sandbox)
    }
    
    func applicationShouldRequestHealthAuthorization(_ application: UIApplication) {
        UNUserNotificationCenter.current()
            .requestAuthorization(
                options: [.alert, .sound, .badge]) { [weak self] granted, _ in
                print("Permission granted: \(granted)")
                guard granted else { return }
                self?.getNotificationSettings()
            }
    }
    
    
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError
                        error: Error) {
        // Try again later.
        print("Permission error: \(error)")
    }
}
extension AppDelegate: UNUserNotificationCenterDelegate{
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if let info = response.notification.request.content.userInfo as? [String:Any] {
            print("Handling notifications with the Local Notification : \(info)")
        }
        completionHandler()
    }
}

// MARK:- Notification names
extension Notification.Name {
    
    /// Notification when user successfully sign in using Google
    static var signInGoogleCompleted: Notification.Name {
        return .init(rawValue: #function)
    }
}


//MARK: Bundle identifier
//com.helpy.user
