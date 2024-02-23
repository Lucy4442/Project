//
//  Register.swift
//  Helpy
//
//  Created by mac on 05/11/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import Moya

struct Register : Codable {

        let data : RegisterData?
        let message : String?
        let status : Int?

        enum CodingKeys: String, CodingKey {
                case data = "data"
                case message = "message"
                case status = "status"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                data = try values.decodeIfPresent(RegisterData.self, forKey: .data)
                message = try values.decodeIfPresent(String.self, forKey: .message)
                status = try values.decodeIfPresent(Int.self, forKey: .status)
        }

}

struct RegisterData : Codable {

        let token : String?
        var user : RegisterUser?

        enum CodingKeys: String, CodingKey {
                case token = "token"
                case user = "user"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                token = try values.decodeIfPresent(String.self, forKey: .token)
                user = try values.decodeIfPresent(RegisterUser.self, forKey: .user)
        }

}

struct RegisterUser : Codable {

        let createdAt : String?
        let email : String?
        let id : Int?
        let loginType : String?
        let mobile : String?
        let otp : Int?
        let referalCode : String?
        let role : String?
        let updatedAt : String?

        enum CodingKeys: String, CodingKey {
                case createdAt = "created_at"
                case email = "email"
                case id = "id"
                case loginType = "login_type"
                case mobile = "mobile"
                case otp = "otp"
                case referalCode = "referal_code"
                case role = "role"
                case updatedAt = "updated_at"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
                email = try values.decodeIfPresent(String.self, forKey: .email)
                id = try values.decodeIfPresent(Int.self, forKey: .id)
                loginType = try values.decodeIfPresent(String.self, forKey: .loginType)
                mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
                otp = try values.decodeIfPresent(Int.self, forKey: .otp)
                referalCode = try values.decodeIfPresent(String.self, forKey: .referalCode)
                role = try values.decodeIfPresent(String.self, forKey: .role)
                updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        }

}
