//
//  UserDetails.swift
//  helpyUser
//
//  Created by mac on 24/05/21.
//

import Foundation

struct UserDetails: Codable {
    let status: Int?
    let message: String?
    let data: [AddressDetails]?
    
    enum CodingKeys: String, CodingKey {
                   case data = "data"
                   case message = "message"
                   case status = "status"
           }
}
struct AddressDetails : Codable {
        var isSelect : Bool = false
        let address : String?
        let city : String?
        let createdAt : String?
        let deletedAt : Int?
        let id : Int?
        let isPrimary : Int?
        let landmark : String?
        let mobile : String?
        let name : String?
        let pincode : String?
        let state : String?
        let updatedAt : String?
        let userId : Int?
        let latitude, longitude: String?
        enum CodingKeys: String, CodingKey {
                case address = "address"
                case city = "city"
                case createdAt = "created_at"
                case deletedAt = "deleted_at"
                case id = "id"
                case isPrimary = "is_primary"
                case landmark = "landmark"
                case mobile = "mobile"
                case name = "name"
                case pincode = "pincode"
                case state = "state"
                case updatedAt = "updated_at"
                case userId = "user_id"
                case longitude, latitude
        }
}
