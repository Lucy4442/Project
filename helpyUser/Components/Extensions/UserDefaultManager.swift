//
//  UserDefaultManager.swift
//  sinc
//
//  Created by mac on 25/02/21.
//

import Foundation


class UserDefaultManager {
    
    static let share = UserDefaultManager()
    
    let defaults = UserDefaults.standard
    
    func storeModelToUserDefault<T>(userData : T , key : UserDefaultModelKeys) where T: Codable{
        defaults.set(try? JSONEncoder().encode(userData) , forKey: key.rawValue)
    }
    
    
    
    func getModelDataFromUserDefults<T : Codable>(userData : T.Type ,key : UserDefaultModelKeys) -> T? {
        print(userData)
        guard let data = defaults.data(forKey: key.rawValue) else {
            return nil
        }
        guard let value = try? JSONDecoder().decode(T.self, from: data) else {
            fatalError("unable to decode this data")
        }
        return value
    }
    func getDataFromUserDefults(key : UserDefaultModelKeys) {
        
    }
    func clearAllUserDataAndModel(){
        for item in UserDefaultModelKeys.allCases {
            removeUserDefualtsModels(key: item)
        }
        for item in UserDefaultKeys.allCases {
            removeUserdefultsKey(key: item)
        }
    }
    
    func removeUserdefultsKey(key : UserDefaultKeys){
        defaults.removeObject(forKey: key.rawValue)
    }
    
    func removeUserDefualtsModels(key : UserDefaultModelKeys){
        defaults.removeObject(forKey: key.rawValue)
    }
    
}
