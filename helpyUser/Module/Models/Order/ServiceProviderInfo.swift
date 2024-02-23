//
//  ServiceProviderInfo.swift
//  helpyUser
//
//  Created by mac on 29/05/21.
//

import Foundation
struct ServiceProviderInfo: Codable {
    let status: Int?
    let message: String?
    var data: ServiceProviderInfoData?
}

// MARK: - DataClass
struct ServiceProviderInfoData: Codable {
    let id: Int?
    let name, mobile: String?
    let avatar: String?
    let address, dataDescription, latitude, logitude: String?
    let review: [Review]?
    let isBookmark: Int?
    var isfavorite = false
    enum CodingKeys: String, CodingKey {
        case id, name, mobile, avatar, address
        case dataDescription = "description"
        case latitude, logitude, review
        case isBookmark = "is_bookmark"
    }
}

// MARK: - Review
struct Review: Codable {
    let id, providerID, userID, review: Int?
    let comment, userName: String?
    let avatar: String?

    enum CodingKeys: String, CodingKey {
        case id
        case providerID = "provider_id"
        case userID = "user_id"
        case review, comment
        case userName = "user_name"
        case avatar
    }
}
