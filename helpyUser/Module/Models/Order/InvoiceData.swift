//
//  InvoiceData.swift
//  HelpyService
//
//  Created by mac on 08/06/21.
//  Copyright © 2021 mac. All rights reserved.
//

import Foundation
struct InvoiceData : Codable {

        let data : Invoice?
        let message : String?
        let status : Int?

        enum CodingKeys: String, CodingKey {
                case data = "data"
                case message = "message"
                case status = "status"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                data = try values.decodeIfPresent(Invoice.self, forKey: .data)
                message = try values.decodeIfPresent(String.self, forKey: .message)
                status = try values.decodeIfPresent(Int.self, forKey: .status)
        }

}
struct Invoice : Codable {

        let id : Int?
        let url : String?

        enum CodingKeys: String, CodingKey {
                case id = "id"
                case url = "url"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                id = try values.decodeIfPresent(Int.self, forKey: .id)
                url = try values.decodeIfPresent(String.self, forKey: .url)
        }

}
