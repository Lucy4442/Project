//
//  OrderDetails.swift
//  helpyUser
//
//  Created by mac on 27/05/21.
//

import Foundation

struct OrderDetails: Codable {
    let status: Int?
    let message: String?
    let data: OrderData?
}

struct OrderData: Codable {
    let orderRequest: [OngoingOrder]
    let ongoingOrder: [OngoingOrder]
    let completedOrder: [OngoingOrder]
    let cancelOrder: [OngoingOrder]

    enum CodingKeys: String, CodingKey {
        case orderRequest = "order_request"
        case ongoingOrder = "order"
        case completedOrder = "previous_order"
        case cancelOrder = "cancel_order"
    }
}

struct OngoingOrder: Codable {
    let id, spID, userID, status: Int?
    let date, parentCategory, subCategory: String?
    let subSubCategory: String?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case id
        case spID = "sp_id"
        case userID = "user_id"
        case date
        case parentCategory = "parent_category"
        case subCategory = "sub_category"
        case subSubCategory = "sub_sub_category"
        case image
        case status
    }
}
