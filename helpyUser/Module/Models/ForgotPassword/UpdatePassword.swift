//
//  UpdatePassword.swift
//  helpyUser
//
//  Created by mac on 11/02/21.
//

import Foundation
struct UpdatePassword : Codable {

        let Sampledata : [String]?
        let message : String?
        let status : Int?

        enum CodingKeys: String, CodingKey {
                case Sampledata = "data"
                case message = "message"
                case status = "status"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
            Sampledata = try values.decodeIfPresent([String].self, forKey: .Sampledata)
                message = try values.decodeIfPresent(String.self, forKey: .message)
                status = try values.decodeIfPresent(Int.self, forKey: .status)
        }

}
