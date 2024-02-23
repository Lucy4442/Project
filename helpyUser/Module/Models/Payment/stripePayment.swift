//
//  stripePayment.swift
//  helpyUser
//
//  Created by mac on 07/07/21.
//

import Foundation
struct stripePayment : Codable {

       // let data : [String]?
        let message : String?
        let status : Int?

        enum CodingKeys: String, CodingKey {
             //   case data = "data"
                case message = "message"
                case status = "status"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                //data = try values.decodeIfPresent([String].self, forKey: .data)
                message = try values.decodeIfPresent(String.self, forKey: .message)
                status = try values.decodeIfPresent(Int.self, forKey: .status)
        }

}
