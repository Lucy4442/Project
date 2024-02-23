//
//  checkMobileNumber.swift
//  helpyUser
//
//  Created by mac on 12/08/21.
//

import Foundation
struct checkMobileNumber : Codable {

        let isRegister : Int?
        let message : String?
        let status : Int?

        enum CodingKeys: String, CodingKey {
                case isRegister = "is_register"
                case message = "message"
                case status = "status"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                isRegister = try values.decodeIfPresent(Int.self, forKey: .isRegister)
                message = try values.decodeIfPresent(String.self, forKey: .message)
                status = try values.decodeIfPresent(Int.self, forKey: .status)
        }
}
