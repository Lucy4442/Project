//
//  AddCardDetails.swift
//  helpyUser
//
//  Created by mac on 09/06/21.
//

import Foundation
struct AddCardDetails : Codable {

        let data : CardDetail?
        let message : String?
        let status : Int?

        enum CodingKeys: String, CodingKey {
                case data = "data"
                case message = "message"
                case status = "status"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                data = try values.decodeIfPresent(CardDetail.self, forKey: .data)
                message = try values.decodeIfPresent(String.self, forKey: .message)
                status = try values.decodeIfPresent(Int.self, forKey: .status)
        }

}
struct CardDetail : Codable {
        var isSelect: Bool = false
        let cardID : String?
        let cardNo : String?
        let createdAt : String?
        let cvc : Int?
        let holderName : String?
        let id : Int?
        let isPrimary : Int?
        let month : Int?
        var paymentType : Int?
        let updatedAt : String?
        let userId : Int?
        let year : Int?

        enum CodingKeys: String, CodingKey {
                case cardNo = "card_no"
                case createdAt = "created_at"
                case cvc = "cvc"
                case holderName = "holder_name"
                case id = "id"
                case isPrimary = "is_primary"
                case month = "month"
                case paymentType = "payment_type"
                case updatedAt = "updated_at"
                case userId = "user_id"
                case year = "year"
                case cardID = "card_id"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                cardNo = try values.decodeIfPresent(String.self, forKey: .cardNo)
                createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
                cvc = try values.decodeIfPresent(Int.self, forKey: .cvc)
                holderName = try values.decodeIfPresent(String.self, forKey: .holderName)
                id = try values.decodeIfPresent(Int.self, forKey: .id)
                isPrimary = try values.decodeIfPresent(Int.self, forKey: .isPrimary)
                month = try values.decodeIfPresent(Int.self, forKey: .month)
                paymentType = try values.decodeIfPresent(Int.self, forKey: .paymentType)
                updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
                userId = try values.decodeIfPresent(Int.self, forKey: .userId)
                year = try values.decodeIfPresent(Int.self, forKey: .year)
                cardID = try values.decodeIfPresent(String.self, forKey: .cardID)
        }

}
struct ReqCardDetail : Codable {
        let cardID : String?
        let cardNo : String?
        let cvc : String?
        let holderName : String?
        let isPrimary : String?
        let month : String?
        let paymentType : String?
        let year : String?
}
