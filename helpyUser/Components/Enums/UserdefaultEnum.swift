//
//  UserdefaultEnum.swift
//  helpyUser
//
//  Created by mac on 23/06/21.
//

import Foundation
enum UserDefaultModelKeys : String, CaseIterable{
    case LoginInfo = "LoginInfo"
    case ProfileInfo = "ProfileInfo"
    case UserProfileInfo = "UserProfileInfo"
    case LoggedInUser = "LoggedInUser"
}
enum UserDefaultKeys : String, CaseIterable{
    case isUserLogin = "isUserLogin"
}
