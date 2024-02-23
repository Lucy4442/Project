//
//  LoaderManager.swift
//  Sleepbot
//
//  Created by Nirav on 06/01/21.
//  Copyright © 2021 Audiojoy. All rights reserved.
//

import Foundation
import MBProgressHUD

class LoaderManager: NSObject {
    
    private static var loadingCount = 0
    
    class func showLoader(message: String? = nil) {
        if loadingCount == 0 {
            // Show loader
            DispatchQueue.main.async {
                let progress = MBProgressHUD.showAdded(to: AppUtility.windowMain()!, animated: true)
                progress.contentColor = UIColor.black
                progress.label.text = message
            }
        }
        loadingCount += 1
    }
    
    class func updateMessage(message: String? = nil) {
        DispatchQueue.main.async {
            MBProgressHUD.forView(AppUtility.windowMain()!)?.label.text = message
        }
    }
    
    class func hideLoader() {
        if loadingCount > 0 {
            loadingCount -= 1
        }
        if loadingCount == 0 {
            // Hide loader
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: AppUtility.windowMain()!, animated: true)
            }
        }
    }
}
