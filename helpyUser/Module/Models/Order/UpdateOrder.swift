//
//  UpdateOrder.swift
//  helpyUser
//
//  Created by mac on 05/08/21.
//

import Foundation
struct UpdateOrder : Codable {

        let data : UpdateOrderDetail?
        let message : String?
        let status : Int?

        enum CodingKeys: String, CodingKey {
                case data = "data"
                case message = "message"
                case status = "status"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                data = try values.decodeIfPresent(UpdateOrderDetail.self, forKey: .data)
                message = try values.decodeIfPresent(String.self, forKey: .message)
                status = try values.decodeIfPresent(Int.self, forKey: .status)
        }

}
struct UpdateOrderDetail : Codable {

        let addonId : String?
        let addressId : Int?
        let categoryAddonPrice : String?
        let categoryCancelationFee : String?
        let categoryCommision : Int?
        let categoryDepthLevel : String?
        let categoryIsCart : String?
        let categoryLabelType : String?
        let categoryMinHour : Int?
        let categoryMinPrice : Int?
        let categoryPrice : Int?
        let categoryPriceType : Int?
        let categoryTax : Int?
        let confirmBy : Int?
        let confirmDatetime : String?
        let createdAt : String?
        let date : String?
        let deliveyTime : String?
        let endTime : String?
        let extraAmount : String?
        let id : Int?
        let invoice : String?
        let isReturn : String?
        let jobDescription : String?
        let jobName : String?
        let jobType : String?
        let note : String?
        let parentId : Int?
        let paymentStatus : Int?
        let paymentType : Int?
        let pdf : String?
        let pickupTime : String?
        let rejectBySp : Int?
        let rejectByUser : String?
        let rejectDatetime : String?
        let rejectReason : String?
        let spId : Int?
        let startTime : String?
        let status : Int?
        let subCategoryId : Int?
        let subSubCategoryId : Int?
        let totalAmount : String?
        let totalHours : String?
        let updatedAt : String?
        let updatedEndTime : String?
        let updatedStartTime : String?
        let userId : Int?

        enum CodingKeys: String, CodingKey {
                case addonId = "addon_id"
                case addressId = "address_id"
                case categoryAddonPrice = "category_addon_price"
                case categoryCancelationFee = "category_cancelation_fee"
                case categoryCommision = "category_commision"
                case categoryDepthLevel = "category_depth_level"
                case categoryIsCart = "category_is_cart"
                case categoryLabelType = "category_label_type"
                case categoryMinHour = "category_min_hour"
                case categoryMinPrice = "category_min_price"
                case categoryPrice = "category_price"
                case categoryPriceType = "category_price_type"
                case categoryTax = "category_tax"
                case confirmBy = "confirm_by"
                case confirmDatetime = "confirm_datetime"
                case createdAt = "created_at"
                case date = "date"
                case deliveyTime = "delivey_time"
                case endTime = "end_time"
                case extraAmount = "extra_amount"
                case id = "id"
                case invoice = "invoice"
                case isReturn = "is_return"
                case jobDescription = "job_description"
                case jobName = "job_name"
                case jobType = "job_type"
                case note = "note"
                case parentId = "parent_id"
                case paymentStatus = "payment_status"
                case paymentType = "payment_type"
                case pdf = "pdf"
                case pickupTime = "pickup_time"
                case rejectBySp = "reject_by_sp"
                case rejectByUser = "reject_by_user"
                case rejectDatetime = "reject_datetime"
                case rejectReason = "reject_reason"
                case spId = "sp_id"
                case startTime = "start_time"
                case status = "status"
                case subCategoryId = "sub_category_id"
                case subSubCategoryId = "sub_sub_category_id"
                case totalAmount = "total_amount"
                case totalHours = "total_hours"
                case updatedAt = "updated_at"
                case updatedEndTime = "updated_end_time"
                case updatedStartTime = "updated_start_time"
                case userId = "user_id"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                addonId = try values.decodeIfPresent(String.self, forKey: .addonId)
                addressId = try values.decodeIfPresent(Int.self, forKey: .addressId)
                categoryAddonPrice = try values.decodeIfPresent(String.self, forKey: .categoryAddonPrice)
                categoryCancelationFee = try values.decodeIfPresent(String.self, forKey: .categoryCancelationFee)
                categoryCommision = try values.decodeIfPresent(Int.self, forKey: .categoryCommision)
                categoryDepthLevel = try values.decodeIfPresent(String.self, forKey: .categoryDepthLevel)
                categoryIsCart = try values.decodeIfPresent(String.self, forKey: .categoryIsCart)
                categoryLabelType = try values.decodeIfPresent(String.self, forKey: .categoryLabelType)
                categoryMinHour = try values.decodeIfPresent(Int.self, forKey: .categoryMinHour)
                categoryMinPrice = try values.decodeIfPresent(Int.self, forKey: .categoryMinPrice)
                categoryPrice = try values.decodeIfPresent(Int.self, forKey: .categoryPrice)
                categoryPriceType = try values.decodeIfPresent(Int.self, forKey: .categoryPriceType)
                categoryTax = try values.decodeIfPresent(Int.self, forKey: .categoryTax)
                confirmBy = try values.decodeIfPresent(Int.self, forKey: .confirmBy)
                confirmDatetime = try values.decodeIfPresent(String.self, forKey: .confirmDatetime)
                createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
                date = try values.decodeIfPresent(String.self, forKey: .date)
                deliveyTime = try values.decodeIfPresent(String.self, forKey: .deliveyTime)
                endTime = try values.decodeIfPresent(String.self, forKey: .endTime)
                extraAmount = try values.decodeIfPresent(String.self, forKey: .extraAmount)
                id = try values.decodeIfPresent(Int.self, forKey: .id)
                invoice = try values.decodeIfPresent(String.self, forKey: .invoice)
                isReturn = try values.decodeIfPresent(String.self, forKey: .isReturn)
                jobDescription = try values.decodeIfPresent(String.self, forKey: .jobDescription)
                jobName = try values.decodeIfPresent(String.self, forKey: .jobName)
                jobType = try values.decodeIfPresent(String.self, forKey: .jobType)
                note = try values.decodeIfPresent(String.self, forKey: .note)
                parentId = try values.decodeIfPresent(Int.self, forKey: .parentId)
                paymentStatus = try values.decodeIfPresent(Int.self, forKey: .paymentStatus)
                paymentType = try values.decodeIfPresent(Int.self, forKey: .paymentType)
                pdf = try values.decodeIfPresent(String.self, forKey: .pdf)
                pickupTime = try values.decodeIfPresent(String.self, forKey: .pickupTime)
                rejectBySp = try values.decodeIfPresent(Int.self, forKey: .rejectBySp)
                rejectByUser = try values.decodeIfPresent(String.self, forKey: .rejectByUser)
                rejectDatetime = try values.decodeIfPresent(String.self, forKey: .rejectDatetime)
                rejectReason = try values.decodeIfPresent(String.self, forKey: .rejectReason)
                spId = try values.decodeIfPresent(Int.self, forKey: .spId)
                startTime = try values.decodeIfPresent(String.self, forKey: .startTime)
                status = try values.decodeIfPresent(Int.self, forKey: .status)
                subCategoryId = try values.decodeIfPresent(Int.self, forKey: .subCategoryId)
                subSubCategoryId = try values.decodeIfPresent(Int.self, forKey: .subSubCategoryId)
                totalAmount = try values.decodeIfPresent(String.self, forKey: .totalAmount)
                totalHours = try values.decodeIfPresent(String.self, forKey: .totalHours)
                updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
                updatedEndTime = try values.decodeIfPresent(String.self, forKey: .updatedEndTime)
                updatedStartTime = try values.decodeIfPresent(String.self, forKey: .updatedStartTime)
                userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        }

}
