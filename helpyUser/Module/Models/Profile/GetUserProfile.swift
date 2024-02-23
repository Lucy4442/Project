//
//  GetUserProfile.swift
//  helpyUser
//
//  Created by mac on 13/02/21.
//

import Foundation
struct GetUserProfile : Codable {
    
    let UserData : UserProfileData?
    let message : String?
    let status : Int?
    
    enum CodingKeys: String, CodingKey {
        case UserData = "data"
        case message = "message"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        UserData = try values.decodeIfPresent(UserProfileData.self, forKey: .UserData)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
    }
    
}
struct UserProfileData : Codable {
    
    let address : String?
    let avatar : String?
    let city : String?
    let id : Int?
    let mobile : String?
    let name : String?
    let state : String?
    let landmark: String?
    let pincode: Int?
    let latitude: String?
    let longitude: String?
    
    enum CodingKeys: String, CodingKey {
        case address = "address"
        case avatar = "avatar"
        case city = "city"
        case id = "id"
        case mobile = "mobile"
        case name = "name"
        case state = "state"
        case landmark = "landmark"
        case pincode = "pincode"
        case latitude = "latitude"
        case longitude = "longitude"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        avatar = try values.decodeIfPresent(String.self, forKey: .avatar)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        state = try values.decodeIfPresent(String.self, forKey: .state)
        landmark = try values.decodeIfPresent(String.self, forKey: .landmark)
        pincode = try values.decodeIfPresent(Int.self, forKey: .pincode)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
    }
    
}
