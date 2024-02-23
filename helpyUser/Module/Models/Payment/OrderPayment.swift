//
//  OrderPayment.swift
//  HelpyService
//
//  Created by mac on 01/06/21.
//  Copyright © 2021 mac. All rights reserved.
//

import Foundation
struct OrderPayment : Codable {

        let data : OrderPaymentDetail?
        let message : String?
        let status : Int?

        enum CodingKeys: String, CodingKey {
                case data = "data"
                case message = "message"
                case status = "status"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
            data = try values.decodeIfPresent(OrderPaymentDetail.self, forKey: .data)
                message = try values.decodeIfPresent(String.self, forKey: .message)
                status = try values.decodeIfPresent(Int.self, forKey: .status)
        }

}
struct OrderPaymentDetail : Codable {

        let addonId : String?
        let avatar : String?
        let categoryIsCart : Int?
        let categoryLabelType : String?
        let categoryMinHour : Int?
        let categoryMinPrice : Int?
        let categoryName : String?
        let categoryPrice : Int?
        let categoryPriceType : Int?
        let categoryTax : Int?
        let id : Int?
        let invoice : String?
        let parentId : Int?
        let subCategoryId : Int?
        let subSubCategoryId : Int?
        let totalHours : String?
        let totalPrice : Int?
        let userId : Int?
        let username : String?
        let date : String?
        let categoryImage: String?

        enum CodingKeys: String, CodingKey {
                case addonId = "addon_id"
                case avatar = "avatar"
                case categoryIsCart = "category_is_cart"
                case categoryLabelType = "category_label_type"
                case categoryMinHour = "category_min_hour"
                case categoryMinPrice = "category_min_price"
                case categoryName = "category_name"
                case categoryPrice = "category_price"
                case categoryPriceType = "category_price_type"
                case categoryTax = "category_tax"
                case id = "id"
                case date = "date"
                case invoice = "invoice"
                case parentId = "parent_id"
                case subCategoryId = "sub_category_id"
                case subSubCategoryId = "sub_sub_category_id"
                case totalHours = "total_hours"
                case totalPrice = "total_price"
                case userId = "user_id"
                case username = "username"
                case categoryImage = "category_image"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                addonId = try values.decodeIfPresent(String.self, forKey: .addonId)
                avatar = try values.decodeIfPresent(String.self, forKey: .avatar)
                categoryIsCart = try values.decodeIfPresent(Int.self, forKey: .categoryIsCart)
                categoryLabelType = try values.decodeIfPresent(String.self, forKey: .categoryLabelType)
                categoryMinHour = try values.decodeIfPresent(Int.self, forKey: .categoryMinHour)
                categoryMinPrice = try values.decodeIfPresent(Int.self, forKey: .categoryMinPrice)
                categoryName = try values.decodeIfPresent(String.self, forKey: .categoryName)
                categoryPrice = try values.decodeIfPresent(Int.self, forKey: .categoryPrice)
                categoryPriceType = try values.decodeIfPresent(Int.self, forKey: .categoryPriceType)
                categoryTax = try values.decodeIfPresent(Int.self, forKey: .categoryTax)
                id = try values.decodeIfPresent(Int.self, forKey: .id)
                invoice = try values.decodeIfPresent(String.self, forKey: .invoice)
                parentId = try values.decodeIfPresent(Int.self, forKey: .parentId)
                subCategoryId = try values.decodeIfPresent(Int.self, forKey: .subCategoryId)
                subSubCategoryId = try values.decodeIfPresent(Int.self, forKey: .subSubCategoryId)
                totalHours = try values.decodeIfPresent(String.self, forKey: .totalHours)
                totalPrice = try values.decodeIfPresent(Int.self, forKey: .totalPrice)
                userId = try values.decodeIfPresent(Int.self, forKey: .userId)
                username = try values.decodeIfPresent(String.self, forKey: .username)
                date = try values.decodeIfPresent(String.self, forKey: .date)
                categoryImage = try values.decodeIfPresent(String.self, forKey: .categoryImage)
        }

}
