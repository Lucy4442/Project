//
//  ParentServices.swift
//  HelpyService
//
//  Created by mac on 19/04/21.
//  Copyright © 2021 mac. All rights reserved.
//

import Foundation
struct ParentServices : Codable {
    
    var Servicedata : [ServiceDetail]?
    var message : String?
    var status : Int?
    
    enum CodingKeys: String, CodingKey {
        case Servicedata = "data"
        case message = "message"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        Servicedata = try values.decodeIfPresent([ServiceDetail].self, forKey: .Servicedata)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
    }
}
struct ServiceDetail : Codable {
    var addons : [Addon]?
    var isselected: Bool = false
    let id : Int?
    let name : String?
    let parentId : Int?
    let descriptionField : String?
    let price : Int?
    let minPrice : Int?
    let priceType : Int?
    let tax : Int?
    let commision : Int?
    let cancelationFee : Int?
    let image : String?
    let startTime : String?
    let endTime : String?
    let serviceTime : Int?
    let isCart : Int?
    let LabelType : String?
    let cat_type : Int?
    let subcategory : [ServiceDetail]?
    let subsubcategory : [ServiceDetail]?
    
    enum CodingKeys: String, CodingKey {
        case addons = "addons"
        case cancelationFee = "cancelation_fee"
        case commision = "commision"
        case descriptionField = "description"
        case endTime = "end_time"
        case id = "id"
        case image = "image"
        case minPrice = "min_price"
        case name = "name"
        case parentId = "parent_id"
        case price = "price"
        case priceType = "price_type"
        case serviceTime = "service_time"
        case startTime = "start_time"
        case tax = "tax"
        case subcategory = "subcategory"
        case subsubcategory = "subsubcategory"
        case isCart = "is_cart"
        case LabelType = "label_type"
        case cat_type = "cat_type"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        addons = try values.decodeIfPresent([Addon].self, forKey: .addons)
        cancelationFee = try values.decodeIfPresent(Int.self, forKey: .cancelationFee)
        commision = try values.decodeIfPresent(Int.self, forKey: .commision)
        descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
        endTime = try values.decodeIfPresent(String.self, forKey: .endTime)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        minPrice = try values.decodeIfPresent(Int.self, forKey: .minPrice)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        parentId = try values.decodeIfPresent(Int.self, forKey: .parentId)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        priceType = try values.decodeIfPresent(Int.self, forKey: .priceType)
        serviceTime = try values.decodeIfPresent(Int.self, forKey: .serviceTime)
        startTime = try values.decodeIfPresent(String.self, forKey: .startTime)
        tax = try values.decodeIfPresent(Int.self, forKey: .tax)
        subcategory = try values.decodeIfPresent([ServiceDetail].self, forKey: .subcategory)
        subsubcategory = try values.decodeIfPresent([ServiceDetail].self, forKey: .subsubcategory)
        isCart = try values.decodeIfPresent(Int.self, forKey: .isCart)
        LabelType = try values.decodeIfPresent(String.self, forKey: .LabelType)
        cat_type = try values.decodeIfPresent(Int.self, forKey: .cat_type)
    }
}
struct Addon : Codable {
    var isSelected : Bool = false
    let addonId : Int?
    let addonName : String?
    let categoryId : Int?
    let id : Int?
    let price : Int?
    let status : Int?
    let AddonDescription : String?
    let addonImage : String?
    let categoryAddonId: Int?
    
    enum CodingKeys: String, CodingKey {
        case addonId = "addon_id"
        case addonName = "addon_name"
        case categoryId = "category_id"
        case id = "id"
        case price = "price"
        case status = "status"
        case AddonDescription = "addon_description"
        case addonImage = "addon_image"
        case categoryAddonId = "category_addon_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        addonId = try values.decodeIfPresent(Int.self, forKey: .addonId)
        addonName = try values.decodeIfPresent(String.self, forKey: .addonName)
        categoryId = try values.decodeIfPresent(Int.self, forKey: .categoryId)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        AddonDescription = try values.decodeIfPresent(String.self, forKey: .AddonDescription)
        addonImage = try values.decodeIfPresent(String.self, forKey: .addonImage)
        categoryAddonId = try values.decodeIfPresent(Int.self, forKey: .categoryAddonId)
    }
    
}
