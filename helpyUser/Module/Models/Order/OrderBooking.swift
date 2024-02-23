//
//  OrderBooking.swift
//  helpyUser
//
//  Created by mac on 27/05/21.
//

import Foundation

struct OrderBooking : Codable {
    
    let data : OrderDetail?
    let message : String?
    let status : Int?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(OrderDetail.self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
    }
}

// MARK: - DataClass
struct OrderDetail : Codable {
    
    let addressId : String?
    let categoryCommision : Int?
    let categoryIsCart : String?
    let categoryLabelType : String?
    let categoryMinHour : Int?
    let categoryMinPrice : Int?
    let categoryPrice : Int?
    let categoryPriceType : Int?
    let categoryTax : Int?
    let createdAt : String?
    let date : String?
    let deliveyTime : String?
    let endTime : String?
    let id : Int?
    let invoice : String?
    let jobDescription : String?
    let jobName : String?
    let jobType : String?
    let parentId : String?
    let pickupTime : String?
    let startTime : String?
    let subCategoryId : String?
    let subSubCategoryId : String?
    let updatedAt : String?
    let userId : Int?
    
    enum CodingKeys: String, CodingKey {
        case addressId = "address_id"
        case categoryCommision = "category_commision"
        case categoryIsCart = "category_is_cart"
        case categoryLabelType = "category_label_type"
        case categoryMinHour = "category_min_hour"
        case categoryMinPrice = "category_min_price"
        case categoryPrice = "category_price"
        case categoryPriceType = "category_price_type"
        case categoryTax = "category_tax"
        case createdAt = "created_at"
        case date = "date"
        case deliveyTime = "delivey_time"
        case endTime = "end_time"
        case id = "id"
        case invoice = "invoice"
        case jobDescription = "job_description"
        case jobName = "job_name"
        case jobType = "job_type"
        case parentId = "parent_id"
        case pickupTime = "pickup_time"
        case startTime = "start_time"
        case subCategoryId = "sub_category_id"
        case subSubCategoryId = "sub_sub_category_id"
        case updatedAt = "updated_at"
        case userId = "user_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        addressId = try values.decodeIfPresent(String.self, forKey: .addressId)
        categoryCommision = try values.decodeIfPresent(Int.self, forKey: .categoryCommision)
        categoryIsCart = try values.decodeIfPresent(String.self, forKey: .categoryIsCart)
        categoryLabelType = try values.decodeIfPresent(String.self, forKey: .categoryLabelType)
        categoryMinHour = try values.decodeIfPresent(Int.self, forKey: .categoryMinHour)
        categoryMinPrice = try values.decodeIfPresent(Int.self, forKey: .categoryMinPrice)
        categoryPrice = try values.decodeIfPresent(Int.self, forKey: .categoryPrice)
        categoryPriceType = try values.decodeIfPresent(Int.self, forKey: .categoryPriceType)
        categoryTax = try values.decodeIfPresent(Int.self, forKey: .categoryTax)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        deliveyTime = try values.decodeIfPresent(String.self, forKey: .deliveyTime)
        endTime = try values.decodeIfPresent(String.self, forKey: .endTime)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        invoice = try values.decodeIfPresent(String.self, forKey: .invoice)
        jobDescription = try values.decodeIfPresent(String.self, forKey: .jobDescription)
        jobName = try values.decodeIfPresent(String.self, forKey: .jobName)
        jobType = try values.decodeIfPresent(String.self, forKey: .jobType)
        parentId = try values.decodeIfPresent(String.self, forKey: .parentId)
        pickupTime = try values.decodeIfPresent(String.self, forKey: .pickupTime)
        startTime = try values.decodeIfPresent(String.self, forKey: .startTime)
        subCategoryId = try values.decodeIfPresent(String.self, forKey: .subCategoryId)
        subSubCategoryId = try values.decodeIfPresent(String.self, forKey: .subSubCategoryId)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
    }
}

struct Booking: Codable {
    let status: Int?
    let message: String?
    let data: BookingData?
}

// MARK: - DataClass
struct BookingData : Codable {
    
    var addons : [Addon]?
    let LabelType : String?
    var address : AddressDetails?
    let avatar : String?
    var date : String?
    let descriptionField : String?
    var endTime : String?
    let getSub : String?
    let getSubSub : String?
    let id : Int?
    let mobile : String?
    let parentCategory : String?
    let parentId : Int?
    let parentImage : String?
    var startTime : String?
    let subImage : String?
    let subSubImage : String?
    let status: String?
    let totalHours : String?
    let updatedEndTime : String?
    let updatedStartTime : String?
    let userId : Int?
    let username : String?
    let categoryImage : String?
    let providerName : String?
    let subCategory : String?
    let price : Int?
    let minPrice : Int?
    let categoryLabelType : String?
    var categoryIsCart : Int?
    let subCategoryId : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case addons = "addons"
        case address = "address"
        case avatar = "avatar"
        case date = "date"
        case descriptionField = "description"
        case endTime = "end_time"
        case getSub = "get_sub"
        case getSubSub = "get_sub_sub"
        case id = "id"
        case mobile = "mobile"
        case parentCategory = "parent_category"
        case parentId = "parent_id"
        case parentImage = "parent_image"
        case startTime = "start_time"
        case subImage = "sub_image"
        case subSubImage = "sub_sub_image"
        case totalHours = "total_hours"
        case updatedEndTime = "updated_end_time"
        case updatedStartTime = "updated_start_time"
        case userId = "user_id"
        case username = "username"
        case status = "status"
        case categoryImage = "category_image"
        case providerName = "provider_name"
        case LabelType = "label_type"
        case subCategory = "sub_category"
        case price = "price"
        case minPrice = "min_price"
        case categoryLabelType = "category_label_type"
        case categoryIsCart = "category_is_cart"
        case subCategoryId = "sub_category_id"
    }
}

