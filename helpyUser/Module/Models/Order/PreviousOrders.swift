//
//  PreviousOrders.swift
//  helpyUser
//
//  Created by mac on 01/06/21.
//

import Foundation
struct PreviousOrders : Codable {

        var data : PreviousOrdersData?
        let message : String?
        let status : Int?

        enum CodingKeys: String, CodingKey {
                case data = "data"
                case message = "message"
                case status = "status"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                data = try values.decodeIfPresent(PreviousOrdersData.self, forKey: .data)
                message = try values.decodeIfPresent(String.self, forKey: .message)
                status = try values.decodeIfPresent(Int.self, forKey: .status)
        }

}
// MARK: - DataClass
struct PreviousOrdersData : Codable {

        var address : Address?
        let isCartPrice : Int?
        let order : Order?

        enum CodingKeys: String, CodingKey {
                case address = "address"
                case isCartPrice = "is_cart_price"
                case order = "order"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                address = try values.decodeIfPresent(Address.self, forKey: .address)
                isCartPrice = try values.decodeIfPresent(Int.self, forKey: .isCartPrice)
                order = try values.decodeIfPresent(Order.self, forKey: .order)
        }

}
// MARK: - Address
struct Address : Codable {

        let address : String?
        let city : String?
        let createdAt : String?
        let deletedAt : Int?
        let id : Int?
        let isPrimary : Int?
        let landmark : String?
        let mobile : String?
        let name : String?
        let pincode : String?
        let state : String?
        let updatedAt : String?
        let userId : Int?

        enum CodingKeys: String, CodingKey {
                case address = "address"
                case city = "city"
                case createdAt = "created_at"
                case deletedAt = "deleted_at"
                case id = "id"
                case isPrimary = "is_primary"
                case landmark = "landmark"
                case mobile = "mobile"
                case name = "name"
                case pincode = "pincode"
                case state = "state"
                case updatedAt = "updated_at"
                case userId = "user_id"
        }
    
    internal init(address: String?, city: String?, createdAt: String?, deletedAt: Int?, id: Int?, isPrimary: Int?, landmark: String?, mobile: String?, name: String?, pincode: String?, state: String?, updatedAt: String?, userId: Int?) {
        self.address = address
        self.city = city
        self.createdAt = createdAt
        self.deletedAt = deletedAt
        self.id = id
        self.isPrimary = isPrimary
        self.landmark = landmark
        self.mobile = mobile
        self.name = name
        self.pincode = pincode
        self.state = state
        self.updatedAt = updatedAt
        self.userId = userId
    }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                address = try values.decodeIfPresent(String.self, forKey: .address)
                city = try values.decodeIfPresent(String.self, forKey: .city)
                createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
                deletedAt = try values.decodeIfPresent(Int.self, forKey: .deletedAt)
                id = try values.decodeIfPresent(Int.self, forKey: .id)
                isPrimary = try values.decodeIfPresent(Int.self, forKey: .isPrimary)
                landmark = try values.decodeIfPresent(String.self, forKey: .landmark)
                mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
                name = try values.decodeIfPresent(String.self, forKey: .name)
                pincode = try values.decodeIfPresent(String.self, forKey: .pincode)
                state = try values.decodeIfPresent(String.self, forKey: .state)
                updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
                userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        }

}
// MARK: - Order
struct Order : Codable {

        let addonId : String?
        let addressId : Int?
        let confirmBy : Int?
        let confirmDatetime : String?
        let createdAt : String?
        let date : String?
        let deliveyTime : String?
        let endTime : String?
        let extraAmount : Int?
        let id : Int?
        let image : String?
        let jobDescription : String?
        let jobName : String?
        let jobType : String?
        let note : String?
        let parentId : Int?
        let parentName : String?
        let paymentStatus : Int?
        let paymentType : Int?
        let pdf : String?
        let pickupTime : String?
        let rejectBySp : Int?
        let rejectByUser : Int?
        let rejectDatetime : String?
        let rejectReason : String?
        let spId : Int?
        let startTime : String?
        let status : Int?
        let subCategoryId : Int?
        let subCategoryName : String?
        let subSubCategoryId : Int?
        let subSubCategoryName : String?
        let totalAmount : Int?
        let totalHours : String?
        let updatedAt : String?
        let updatedEndTime : String?
        let updatedStartTime : String?
        let userId : Int?

        enum CodingKeys: String, CodingKey {
                case addonId = "addon_id"
                case addressId = "address_id"
                case confirmBy = "confirm_by"
                case confirmDatetime = "confirm_datetime"
                case createdAt = "created_at"
                case date = "date"
                case deliveyTime = "delivey_time"
                case endTime = "end_time"
                case extraAmount = "extra_amount"
                case id = "id"
                case image = "image"
                case jobDescription = "job_description"
                case jobName = "job_name"
                case jobType = "job_type"
                case note = "note"
                case parentId = "parent_id"
                case parentName = "parent_name"
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
                case subCategoryName = "sub_category_name"
                case subSubCategoryId = "sub_sub_category_id"
                case subSubCategoryName = "sub_sub_category_name"
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
                confirmBy = try values.decodeIfPresent(Int.self, forKey: .confirmBy)
                confirmDatetime = try values.decodeIfPresent(String.self, forKey: .confirmDatetime)
                createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
                date = try values.decodeIfPresent(String.self, forKey: .date)
                deliveyTime = try values.decodeIfPresent(String.self, forKey: .deliveyTime)
                endTime = try values.decodeIfPresent(String.self, forKey: .endTime)
                extraAmount = try values.decodeIfPresent(Int.self, forKey: .extraAmount)
                id = try values.decodeIfPresent(Int.self, forKey: .id)
                image = try values.decodeIfPresent(String.self, forKey: .image)
                jobDescription = try values.decodeIfPresent(String.self, forKey: .jobDescription)
                jobName = try values.decodeIfPresent(String.self, forKey: .jobName)
                jobType = try values.decodeIfPresent(String.self, forKey: .jobType)
                note = try values.decodeIfPresent(String.self, forKey: .note)
                parentId = try values.decodeIfPresent(Int.self, forKey: .parentId)
                parentName = try values.decodeIfPresent(String.self, forKey: .parentName)
                paymentStatus = try values.decodeIfPresent(Int.self, forKey: .paymentStatus)
                paymentType = try values.decodeIfPresent(Int.self, forKey: .paymentType)
                pdf = try values.decodeIfPresent(String.self, forKey: .pdf)
                pickupTime = try values.decodeIfPresent(String.self, forKey: .pickupTime)
                rejectBySp = try values.decodeIfPresent(Int.self, forKey: .rejectBySp)
                rejectByUser = try values.decodeIfPresent(Int.self, forKey: .rejectByUser)
                rejectDatetime = try values.decodeIfPresent(String.self, forKey: .rejectDatetime)
                rejectReason = try values.decodeIfPresent(String.self, forKey: .rejectReason)
                spId = try values.decodeIfPresent(Int.self, forKey: .spId)
                startTime = try values.decodeIfPresent(String.self, forKey: .startTime)
                status = try values.decodeIfPresent(Int.self, forKey: .status)
                subCategoryId = try values.decodeIfPresent(Int.self, forKey: .subCategoryId)
                subCategoryName = try values.decodeIfPresent(String.self, forKey: .subCategoryName)
                subSubCategoryId = try values.decodeIfPresent(Int.self, forKey: .subSubCategoryId)
                subSubCategoryName = try values.decodeIfPresent(String.self, forKey: .subSubCategoryName)
                totalAmount = try values.decodeIfPresent(Int.self, forKey: .totalAmount)
                totalHours = try values.decodeIfPresent(String.self, forKey: .totalHours)
                updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
                updatedEndTime = try values.decodeIfPresent(String.self, forKey: .updatedEndTime)
                updatedStartTime = try values.decodeIfPresent(String.self, forKey: .updatedStartTime)
                userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        }

}
