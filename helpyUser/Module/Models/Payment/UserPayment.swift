//
//  UserPayment.swift
//  helpyUser
//
//  Created by mac on 19/06/21.
//

import Foundation
struct UserPayment : Codable {

        let data : PaymentData?
        let message : String?
        let status : Int?

        enum CodingKeys: String, CodingKey {
                case data = "data"
                case message = "message"
                case status = "status"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                data = try values.decodeIfPresent(PaymentData.self, forKey: .data)
                message = try values.decodeIfPresent(String.self, forKey: .message)
                status = try values.decodeIfPresent(Int.self, forKey: .status)
        }

}
struct PaymentData : Codable {

        let addressId : Int?
        let amountPayble : Int?
        let category : String?
        let categoryImage : String?
        let confirmDatetime : String?
        let date : String?
        let deliveryCharge : Int?
        let extraAmount : Int?
        let feedback : String?
        let id : Int?
        let invoice : String?
        let parentId : Int?
        let review : Int?
        let spAddress : String?
        let spId : Int?
        let spImage : String?
        let spName : String?
        let subCategoryId : Int?
        let subSubCategoryId : Int?
        let totalAmount : Int?
        let totalHours : String?
        let totalPrice : Int?
        let url : String?
        let userAddress : String?
        let userId : Int?
        let userImage : String?
        let username : String?

        enum CodingKeys: String, CodingKey {
                case addressId = "address_id"
                case amountPayble = "amount_payble"
                case category = "category"
                case categoryImage = "category_image"
                case confirmDatetime = "confirm_datetime"
                case date = "date"
                case deliveryCharge = "Delivery_charge"
                case extraAmount = "extra_amount"
                case feedback = "feedback"
                case id = "id"
                case invoice = "invoice"
                case parentId = "parent_id"
                case review = "review"
                case spAddress = "sp_address"
                case spId = "sp_id"
                case spImage = "sp_image"
                case spName = "sp_name"
                case subCategoryId = "sub_category_id"
                case subSubCategoryId = "sub_sub_category_id"
                case totalAmount = "total_amount"
                case totalHours = "total_hours"
                case totalPrice = "total_price"
                case url = "url"
                case userAddress = "user_address"
                case userId = "user_id"
                case userImage = "user_image"
                case username = "username"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                addressId = try values.decodeIfPresent(Int.self, forKey: .addressId)
                amountPayble = try values.decodeIfPresent(Int.self, forKey: .amountPayble)
                category = try values.decodeIfPresent(String.self, forKey: .category)
                categoryImage = try values.decodeIfPresent(String.self, forKey: .categoryImage)
                confirmDatetime = try values.decodeIfPresent(String.self, forKey: .confirmDatetime)
                date = try values.decodeIfPresent(String.self, forKey: .date)
                deliveryCharge = try values.decodeIfPresent(Int.self, forKey: .deliveryCharge)
                extraAmount = try values.decodeIfPresent(Int.self, forKey: .extraAmount)
                feedback = try values.decodeIfPresent(String.self, forKey: .feedback)
                id = try values.decodeIfPresent(Int.self, forKey: .id)
                invoice = try values.decodeIfPresent(String.self, forKey: .invoice)
                parentId = try values.decodeIfPresent(Int.self, forKey: .parentId)
                review = try values.decodeIfPresent(Int.self, forKey: .review)
                spAddress = try values.decodeIfPresent(String.self, forKey: .spAddress)
                spId = try values.decodeIfPresent(Int.self, forKey: .spId)
                spImage = try values.decodeIfPresent(String.self, forKey: .spImage)
                spName = try values.decodeIfPresent(String.self, forKey: .spName)
                subCategoryId = try values.decodeIfPresent(Int.self, forKey: .subCategoryId)
                subSubCategoryId = try values.decodeIfPresent(Int.self, forKey: .subSubCategoryId)
                totalAmount = try values.decodeIfPresent(Int.self, forKey: .totalAmount)
                totalHours = try values.decodeIfPresent(String.self, forKey: .totalHours)
                totalPrice = try values.decodeIfPresent(Int.self, forKey: .totalPrice)
                url = try values.decodeIfPresent(String.self, forKey: .url)
                userAddress = try values.decodeIfPresent(String.self, forKey: .userAddress)
                userId = try values.decodeIfPresent(Int.self, forKey: .userId)
                userImage = try values.decodeIfPresent(String.self, forKey: .userImage)
                username = try values.decodeIfPresent(String.self, forKey: .username)
        }

}
