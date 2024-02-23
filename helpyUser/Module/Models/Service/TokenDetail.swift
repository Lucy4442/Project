//
//  TokenDetail.swift
//  HelpyService
//
//  Created by mac on 27/07/21.
//  Copyright © 2021 mac. All rights reserved.
//

import Foundation
struct TokenDetail : Codable {

        let data : TokenData?
        let message : String?
        let status : Int?

        enum CodingKeys: String, CodingKey {
                case data = "data"
                case message = "message"
                case status = "status"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                data = try values.decodeIfPresent(TokenData.self, forKey: .data)
                message = try values.decodeIfPresent(String.self, forKey: .message)
                status = try values.decodeIfPresent(Int.self, forKey: .status)
        }

}
struct TokenData : Codable {

        let accessToken : String?
        let address : String?
        let appleId : String?
        let avatar : String?
        let categoryId : String?
        let city : String?
        let createdAt : String?
        let deletedAt : String?
        let deviceToken : String?
        let email : String?
        let emailVerifiedAt : String?
        let facebookId : String?
        let googleId : String?
        let id : Int?
        let isBlock : Int?
        let loginType : Int?
        let mobile : String?
        let name : String?
        let otp : String?
        let otpVerify : Int?
        let provider : String?
        let providerId : String?
        let referalCode : String?
        let role : Int?
        let state : String?
        let status : Int?
        let updatedAt : String?

        enum CodingKeys: String, CodingKey {
                case accessToken = "access_token"
                case address = "address"
                case appleId = "apple_id"
                case avatar = "avatar"
                case categoryId = "category_id"
                case city = "city"
                case createdAt = "created_at"
                case deletedAt = "deleted_at"
                case deviceToken = "device_token"
                case email = "email"
                case emailVerifiedAt = "email_verified_at"
                case facebookId = "facebook_id"
                case googleId = "google_id"
                case id = "id"
                case isBlock = "is_block"
                case loginType = "login_type"
                case mobile = "mobile"
                case name = "name"
                case otp = "otp"
                case otpVerify = "otp_verify"
                case provider = "provider"
                case providerId = "provider_id"
                case referalCode = "referal_code"
                case role = "role"
                case state = "state"
                case status = "status"
                case updatedAt = "updated_at"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                accessToken = try values.decodeIfPresent(String.self, forKey: .accessToken)
                address = try values.decodeIfPresent(String.self, forKey: .address)
                appleId = try values.decodeIfPresent(String.self, forKey: .appleId)
                avatar = try values.decodeIfPresent(String.self, forKey: .avatar)
                categoryId = try values.decodeIfPresent(String.self, forKey: .categoryId)
                city = try values.decodeIfPresent(String.self, forKey: .city)
                createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
                deletedAt = try values.decodeIfPresent(String.self, forKey: .deletedAt)
                deviceToken = try values.decodeIfPresent(String.self, forKey: .deviceToken)
                email = try values.decodeIfPresent(String.self, forKey: .email)
                emailVerifiedAt = try values.decodeIfPresent(String.self, forKey: .emailVerifiedAt)
                facebookId = try values.decodeIfPresent(String.self, forKey: .facebookId)
                googleId = try values.decodeIfPresent(String.self, forKey: .googleId)
                id = try values.decodeIfPresent(Int.self, forKey: .id)
                isBlock = try values.decodeIfPresent(Int.self, forKey: .isBlock)
                loginType = try values.decodeIfPresent(Int.self, forKey: .loginType)
                mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
                name = try values.decodeIfPresent(String.self, forKey: .name)
                otp = try values.decodeIfPresent(String.self, forKey: .otp)
                otpVerify = try values.decodeIfPresent(Int.self, forKey: .otpVerify)
                provider = try values.decodeIfPresent(String.self, forKey: .provider)
                providerId = try values.decodeIfPresent(String.self, forKey: .providerId)
                referalCode = try values.decodeIfPresent(String.self, forKey: .referalCode)
                role = try values.decodeIfPresent(Int.self, forKey: .role)
                state = try values.decodeIfPresent(String.self, forKey: .state)
                status = try values.decodeIfPresent(Int.self, forKey: .status)
                updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        }

}
