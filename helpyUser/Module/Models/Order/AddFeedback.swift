//
//  AddFeedback.swift
//  helpyUser
//
//  Created by mac on 23/06/21.
//

import Foundation
struct AddFeedback : Codable {

        let data : FeedbackData?
        let message : String?
        let status : Int?

        enum CodingKeys: String, CodingKey {
                case data = "data"
                case message = "message"
                case status = "status"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                data = try values.decodeIfPresent(FeedbackData.self, forKey: .data)
                message = try values.decodeIfPresent(String.self, forKey: .message)
                status = try values.decodeIfPresent(Int.self, forKey: .status)
        }

}
struct FeedbackData : Codable {

        let comment : String?
        let createdAt : String?
        let id : Int?
        let providerId : String?
        let review : String?
        let updatedAt : String?
        let userId : Int?

        enum CodingKeys: String, CodingKey {
                case comment = "comment"
                case createdAt = "created_at"
                case id = "id"
                case providerId = "provider_id"
                case review = "review"
                case updatedAt = "updated_at"
                case userId = "user_id"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                comment = try values.decodeIfPresent(String.self, forKey: .comment)
                createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
                id = try values.decodeIfPresent(Int.self, forKey: .id)
                providerId = try values.decodeIfPresent(String.self, forKey: .providerId)
                review = try values.decodeIfPresent(String.self, forKey: .review)
                updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
                userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        }

}
