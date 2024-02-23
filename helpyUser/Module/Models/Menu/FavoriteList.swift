//
//  FavoriteList.swift
//  helpyUser
//
//  Created by mac on 09/06/21.
//

import Foundation
struct FavoriteList : Codable {

        let data : [FavoriteData]?
        let message : String?
        let status : Int?

        enum CodingKeys: String, CodingKey {
                case data = "data"
                case message = "message"
                case status = "status"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                data = try values.decodeIfPresent([FavoriteData].self, forKey: .data)
                message = try values.decodeIfPresent(String.self, forKey: .message)
                status = try values.decodeIfPresent(Int.self, forKey: .status)
        }

}
struct FavoriteData : Codable {

        let address : String?
        let avatar : String?
        let id : Int?
        let jobName : String?
        let orderId : Int?
        let providerId : Int?
        let providerName : String?
        let rating : Int?
        let userId : Int?

        enum CodingKeys: String, CodingKey {
                case address = "address"
                case avatar = "avatar"
                case id = "id"
                case jobName = "job_name"
                case orderId = "order_id"
                case providerId = "provider_id"
                case providerName = "provider_name"
                case rating = "rating"
                case userId = "user_id"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                address = try values.decodeIfPresent(String.self, forKey: .address)
                avatar = try values.decodeIfPresent(String.self, forKey: .avatar)
                id = try values.decodeIfPresent(Int.self, forKey: .id)
                jobName = try values.decodeIfPresent(String.self, forKey: .jobName)
                orderId = try values.decodeIfPresent(Int.self, forKey: .orderId)
                providerId = try values.decodeIfPresent(Int.self, forKey: .providerId)
                providerName = try values.decodeIfPresent(String.self, forKey: .providerName)
                rating = try values.decodeIfPresent(Int.self, forKey: .rating)
                userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        }

}
