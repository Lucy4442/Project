//
//  UpdateUserProfile.swift
//  helpyUser
//
//  Created by mac on 11/02/21.
//

import Foundation
struct UpdateUserProfile : Codable {

        let userdata : UserData?
        let message : String?
        let status : Int?

        enum CodingKeys: String, CodingKey {
                case userdata = "data"
                case message = "message"
                case status = "status"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
            userdata = try values.decodeIfPresent(UserData.self, forKey: .userdata)
                message = try values.decodeIfPresent(String.self, forKey: .message)
                status = try values.decodeIfPresent(Int.self, forKey: .status)
        }

}
struct UserData : Codable {

        let accessToken : String?
        let address : AddressDetails?
        let appleId : String?
        let approvedService : [ApprovedService]?
        let avatar : String?
        let categoryId : String?
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
        let requestedService : [RequestedService]?
        let role : Int?
        let status : Int?
        let updatedAt : String?

        enum CodingKeys: String, CodingKey {
                case accessToken = "access_token"
                case address = "address"
                case appleId = "apple_id"
                case approvedService = "approved_service"
                case avatar = "avatar"
                case categoryId = "category_id"
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
                case requestedService = "requested_service"
                case role = "role"
                case status = "status"
                case updatedAt = "updated_at"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                accessToken = try values.decodeIfPresent(String.self, forKey: .accessToken)
                address = try values.decodeIfPresent(AddressDetails.self, forKey: .address)
                appleId = try values.decodeIfPresent(String.self, forKey: .appleId)
                approvedService = try values.decodeIfPresent([ApprovedService].self, forKey: .approvedService)
                avatar = try values.decodeIfPresent(String.self, forKey: .avatar)
                categoryId = try values.decodeIfPresent(String.self, forKey: .categoryId)
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
                requestedService = try values.decodeIfPresent([RequestedService].self, forKey: .requestedService)
                role = try values.decodeIfPresent(Int.self, forKey: .role)
                status = try values.decodeIfPresent(Int.self, forKey: .status)
                updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        }

}
struct RequestedService : Codable {
    
    let categoryId : String?
    let id : Int?
    let parentCategory : String?
    let parentId : Int?
    let parentImage : String?
    let status : Int?
    let subCatId : Int?
    let subCategory : String?
    let subSubCategory : String?
    let subcatImage : String?
    let subsubcatImage : String?
    let userId : Int?
    
    enum CodingKeys: String, CodingKey {
        case categoryId = "category_id"
        case id = "id"
        case parentCategory = "parent_category"
        case parentId = "parent_id"
        case parentImage = "parent_image"
        case status = "status"
        case subCatId = "sub_cat_id"
        case subCategory = "sub_category"
        case subSubCategory = "sub_sub_category"
        case subcatImage = "subcat_image"
        case subsubcatImage = "subsubcat_image"
        case userId = "user_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        categoryId = try values.decodeIfPresent(String.self, forKey: .categoryId)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        parentCategory = try values.decodeIfPresent(String.self, forKey: .parentCategory)
        parentId = try values.decodeIfPresent(Int.self, forKey: .parentId)
        parentImage = try values.decodeIfPresent(String.self, forKey: .parentImage)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        subCatId = try values.decodeIfPresent(Int.self, forKey: .subCatId)
        subCategory = try values.decodeIfPresent(String.self, forKey: .subCategory)
        subSubCategory = try values.decodeIfPresent(String.self, forKey: .subSubCategory)
        subcatImage = try values.decodeIfPresent(String.self, forKey: .subcatImage)
        subsubcatImage = try values.decodeIfPresent(String.self, forKey: .subsubcatImage)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
    }
    
}
struct ApprovedService : Codable {
    
    let categoryId : String?
    let id : Int?
    let parentCategory : String?
    let parentId : Int?
    let parentImage : String?
    let status : Int?
    let subCatId : Int?
    let subCategory : String?
    let subSubCategory : String?
    let subcatImage : String?
    let subsubcatImage : String?
    let userId : Int?
    
    enum CodingKeys: String, CodingKey {
        case categoryId = "category_id"
        case id = "id"
        case parentCategory = "parent_category"
        case parentId = "parent_id"
        case parentImage = "parent_image"
        case status = "status"
        case subCatId = "sub_cat_id"
        case subCategory = "sub_category"
        case subSubCategory = "sub_sub_category"
        case subcatImage = "subcat_image"
        case subsubcatImage = "subsubcat_image"
        case userId = "user_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        categoryId = try values.decodeIfPresent(String.self, forKey: .categoryId)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        parentCategory = try values.decodeIfPresent(String.self, forKey: .parentCategory)
        parentId = try values.decodeIfPresent(Int.self, forKey: .parentId)
        parentImage = try values.decodeIfPresent(String.self, forKey: .parentImage)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        subCatId = try values.decodeIfPresent(Int.self, forKey: .subCatId)
        subCategory = try values.decodeIfPresent(String.self, forKey: .subCategory)
        subSubCategory = try values.decodeIfPresent(String.self, forKey: .subSubCategory)
        subcatImage = try values.decodeIfPresent(String.self, forKey: .subcatImage)
        subsubcatImage = try values.decodeIfPresent(String.self, forKey: .subsubcatImage)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
    }
    
}
