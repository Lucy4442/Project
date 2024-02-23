//
//  addFavorite.swift
//  helpyUser
//
//  Created by mac on 12/07/21.
//

import Foundation
struct addFavorite : Codable {
    
    let data : favoriteDetail?
    let message : String?
    let status : Int?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(favoriteDetail.self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
    }
    
}
struct favoriteDetail : Codable {
    
    let createdAt : String?
    let id : Int?
    let isBookmark : Int?
    let providerId : Int?
    let updatedAt : String?
    let userId : Int?
    let orderId: Int?
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case id = "id"
        case isBookmark = "is_bookmark"
        case providerId = "provider_id"
        case updatedAt = "updated_at"
        case userId = "user_id"
        case orderId = "order_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        isBookmark = try values.decodeIfPresent(Int.self, forKey: .isBookmark)
        providerId = try values.decodeIfPresent(Int.self, forKey: .providerId)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        orderId = try values.decodeIfPresent(Int.self, forKey: .orderId)
    }
    
}
