//
//  CancelOrder.swift
//  helpyUser
//
//  Created by mac on 28/05/21.
//

import Foundation
struct CancelOrder: Codable {
    let status: Int?
    let message: String?
    let data: CancelOrderDetails?
}

// MARK: - DataClass
struct CancelOrderDetails: Codable {
    let id, userID, parentID: Int?
    let rejectDatetime, rejectReason: String?
    let canclebyuser: String?
    let canclebysp, status: Int?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case parentID = "parent_id"
        case rejectDatetime = "reject_datetime"
        case rejectReason = "reject_reason"
        case canclebyuser, canclebysp, status
        case updatedAt = "updated_at"
    }
}
