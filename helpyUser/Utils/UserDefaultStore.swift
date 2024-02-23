//
//  UserDefaultStore.swift
//  HelpyService
//
//  Created by mac on 19/11/21.
//  Copyright © 2021 mac. All rights reserved.
//

import Foundation

struct UserDefaultStore {
    
    public enum Key: String {
        case isProfileComplated
    }

    static fileprivate let userDefaults: UserDefaults = UserDefaults.standard
    
    static func value<T>(key: Key) -> T? {
        return self.userDefaults.object(forKey: key.rawValue) as? T
    }
    
    static func write<T>(key: Key, value: T?) {
        self.userDefaults.set(value, forKey: key.rawValue)
    }
    
    static func remove(key: Key) {
        self.userDefaults.set(nil, forKey: key.rawValue)
    }
}
