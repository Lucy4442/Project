//
//  APIManager.swift
//  Helpy
//
//  Created by mac on 12/11/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import  Moya
import Toast_Swift

class APIManager: NSObject{
    
    let provider = MoyaProvider<HelpyAPI>()
    static let share = APIManager()
    
    func handleDecode<T>(result : Result<Moya.Response,MoyaError>,valueToDecode : @escaping (Result<T,Error>)->Void) where T: Codable {
        print(T.self)
        switch result {
        case .success(let response):
            do{
                let json = try JSONDecoder().decode(T.self, from: response.data)
                switch response.statusCode {
                case 200...299:
                    //                success
                    valueToDecode(.success(json))
                    break
                case 300...399:
                    let jsonData = try JSONDecoder().decode(ErrorModel.self, from: response.data)
                    let data = handleError(data: jsonData)
                    valueToDecode(.failure(data))
                    break
                case 400...499:
                    let jsonData = try JSONDecoder().decode(ErrorModel.self, from: response.data)
                    let data = handleError(data: jsonData)
                    valueToDecode(.failure(data))
                    break
                case 500...599:
                    let jsonData = try JSONDecoder().decode(ErrorModel.self, from: response.data)
                    let data = handleError(data: jsonData)
                    valueToDecode(.failure(data))
                    break
                    
                default:
                    let jsonData = try JSONDecoder().decode(ErrorModel.self, from: response.data)
                    let data = handleError(data: jsonData)
                    valueToDecode(.failure(data))
                    break
                }
            } catch {
                print(" Error = \(error.localizedDescription)")
                valueToDecode(.failure(error))
            }
        case .failure(let error):
            print(" Error = \(error.localizedDescription)")
            valueToDecode(.failure(error))
            break
        }
    }
    func handleError(data : ErrorModel?) -> MoyaError {
        let errror = NSError.init(domain: "com.helpy", code: 0, userInfo: [NSLocalizedDescriptionKey: data?.message ?? "Something Went Wrong"])
        let error = MoyaError.underlying(errror, nil)
        return error
    }
    struct ErrorModel : Codable {
        let message : String?
        let status : Int?
        
        enum CodingKeys: String, CodingKey {
            case message = "message"
            case status = "status"
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            message = try values.decodeIfPresent(String.self, forKey: .message)
            status = try values.decodeIfPresent(Int.self, forKey: .status)
        }
    }
    func login(mobile: String, password: String, email: String, user_type: String, login_type: String, Social_id: String, viewcontroller: UIViewController, completion: @escaping (Result<Login, Error>) -> Void){
        provider.request(.login(mobile: mobile, password: password, email: email, user_type: user_type, login_type: login_type, social_id: Social_id)) { (Result) in
            self.handleDecode(result: Result, valueToDecode: completion)
        }
    }
    func register(mobile: String, password: String, email: String, social_id: String, user_type :String , login_type : String, viewcontroller: UIViewController,
                  completion: @escaping  (Result<Register,Error>)-> Void){
        provider.request(.Register(mobile: mobile, password: password, email: email, social_id: social_id, user_type: user_type, login_type: login_type)) { (Result) in
            self.handleDecode(result: Result, valueToDecode: completion)
        }
    }
    
    func generateNewpassword(mobile: String, password: String, completion: @escaping (Result<UpdatePassword,Error>) -> Void){
        provider.request(.UpdatePassword(mobile: mobile, password: password)) { (Result) in
            self.handleDecode(result: Result, valueToDecode: completion)
        }
    }
    
    func UpdateProfile(name: String, mobile: String, address: String, city: String, state: String, Avatar: Data, user_type: String, landMark: String, pinCode: String, latitude: String, longitude: String, completion: @escaping (Result<UpdateUserProfile,Error>) -> Void ){
        provider.request(.UpdateProfile(name: name, mobile: mobile, address: address, city: city, state: state, avatar: Avatar, user_type: user_type,landmark: landMark, pinCode: pinCode,latitude: latitude, longitude: longitude)) { (Result) in
            self.handleDecode(result: Result, valueToDecode: completion)
        }
    }
    
    func UserProfileData(completion: @escaping (Result<GetUserProfile, Error>) -> Void){
        provider.request(.GetUserProfileData) { (Result) in
            self.handleDecode(result: Result, valueToDecode: completion)
        }
    }
    
    func GetParentServicesData(completion: @escaping (Result<ParentServices, Error>) -> Void){
        provider.request(.GetParentServices) { (Result) in
            self.handleDecode(result: Result, valueToDecode: completion)
        }
    }
    
    func GetSubServiceData(serviceID: String, completion: @escaping (Result<ParentServices, Error>) -> Void){
        print("serviceID: \(serviceID)")
        provider.request(.GetSubServices(service_id: serviceID)) { (Result) in
            self.handleDecode(result: Result, valueToDecode: completion)
        }
    }
    
    func GetUserAddressData(completion: @escaping (Result<UserDetails, Error>) -> Void){
        provider.request(.GetAllAddress) { (Result) in
            self.handleDecode(result: Result, valueToDecode: completion)
        }
    }
    
    func AdduserAddress(username: String, mobile: String, address: String, city: String, state: String, landmark: String,pincode: String,is_primary: String,latitude: String, longitude: String,completion: @escaping (Result<AddressData,Error>) -> Void ){
        provider.request(.AddAddress(mobile: mobile, address: address, username: username, city: city, state: state, landmark: landmark, pincode: pincode, is_primary: is_primary,latitude: latitude, longitude: longitude)) { (Result) in
            self.handleDecode(result: Result, valueToDecode: completion)
        }
    }
    
    func DeleteAddress(addressID: String, completion: @escaping (Result<UserDetails,Error>) -> Void ) {
        provider.request(.DeleteAddress(address_id: addressID)) { (Result) in
            self.handleDecode(result: Result, valueToDecode: completion)
        }
    }
    
    func GetAddressDetails(addressID: String, completion: @escaping (Result<AddressData,Error>) -> Void ) {
        provider.request(.GetAddressDetails(address_id: addressID)) { (Result) in
            self.handleDecode(result: Result, valueToDecode: completion)
        }
    }
    
    func updateAddress(address_id: Int, username: String, mobile: String, address: String, city: String, state: String, pincode: String, landmark: String, is_primary: String,latitude: String, longitude: String, completion: @escaping (Result<AddressData,Error>) -> Void ) {
        provider.request(.UpdateAddress(address_id: address_id, username: username, mobile: mobile, address: address, city: city, state: state, pincode: pincode, landmark: landmark, is_primary: is_primary,latitude: latitude, longitude: longitude)) { (Result) in
            self.handleDecode(result: Result, valueToDecode: completion)
        }
    }
    
    func GetOrderListData(completion: @escaping (Result<OrderDetails, Error>) -> Void){
        provider.request(.GetOrderList) { (Result) in
            self.handleDecode(result: Result, valueToDecode: completion)
        }
    }
    
    func OrderBooking(job_type: String, parent_id: String, sub_category_id: String, sub_sub_category_id: String, date: String, start_time: String, end_time: String, address_id: String, job_name: String, job_description: String, label_type: String, is_cart: String, addon_id: String,completion: @escaping (Result<OrderBooking, Error>) -> Void) {
        provider.request(.OrderBooking(job_type: job_type, parent_id: parent_id, sub_category_id: sub_category_id, sub_sub_category_id: sub_sub_category_id, date: date, start_time: start_time, end_time: end_time, address_id: address_id, job_name: job_name, job_description: job_description, label_type: label_type, is_cart: is_cart, addon_id: addon_id)) { (Result) in
            self.handleDecode(result: Result, valueToDecode: completion)
        }
    }
    
    func OrderBookingDetails(booking_id: String,completion: @escaping (Result<Booking, Error>) -> Void) {
        provider.request(.OrderBookingDetails(booking_id: booking_id)) { (Result) in
            self.handleDecode(result: Result, valueToDecode: completion)
        }
    }
    
    func CancelOrder(order_id: String, cancel_reason: String, completion: @escaping (Result<CancelOrder, Error>) -> Void) {
        provider.request(.CancelOrder(order_id: order_id, cancel_reason: cancel_reason)) { (Result) in
            self.handleDecode(result: Result, valueToDecode: completion)
        }
    }
    
    func UserOrderDetails(order_id: String,completion: @escaping (Result<Booking, Error>) -> Void) {
        provider.request(.UserOrderDetails(order_id: order_id)) { (Result) in
            self.handleDecode(result: Result, valueToDecode: completion)
        }
    }
    
    func GetServiceProviderInfo(booking_id: String, completion: @escaping (Result<ServiceProviderInfo, Error>) -> Void) {
        provider.request(.GetServiceProviderInfo(booking_id: booking_id)) { (Result) in
            self.handleDecode(result: Result, valueToDecode: completion)
        }
    }
    
    func GetPreviousOrders(label: String, Cart: String,completion: @escaping (Result<PreviousOrders, Error>) -> Void) {
        provider.request(.GetPreviousOrders(label_type: label, is_cart: Cart)) { (Result) in
            self.handleDecode(result: Result, valueToDecode: completion)
        }
    }
    
    func GetFavoriteListData(completion: @escaping (Result<FavoriteList, Error>) -> Void){
        provider.request(.GetFavoriteList) { (Result) in
            self.handleDecode(result: Result, valueToDecode: completion)
        }
    }
    
    func GetCardDetail(completion: @escaping (Result<GetCardDetails, Error>) -> Void){
        provider.request(.GetCardDetails) { (Result) in
            self.handleDecode(result: Result, valueToDecode: completion)
        }
    }
    func AddCardDetail(params: ReqCardDetail, completion: @escaping (Result<AddCardDetails, Error>) -> Void){
        provider.request(.AddCardDetails(Param: params)) { (Result) in
            self.handleDecode(result: Result, valueToDecode: completion)
        }
    }
    
    func UpdateCardDetail(params: ReqCardDetail, completion: @escaping (Result<AddCardDetails, Error>) -> Void){
        provider.request(.UpdateCardDetails(param: params)) { (Result) in
            self.handleDecode(result: Result, valueToDecode: completion)
        }
    }
    func DeleteCard(cardID: String,completion: @escaping (Result<GetCardDetails, Error>) -> Void){
        provider.request(.DeleteCard(card_id: cardID)) { (Result) in
            self.handleDecode(result: Result, valueToDecode: completion)
        }
    }
    func cardPrimaryInfo(completion: @escaping (Result<AddCardDetails, Error>) -> Void){
        provider.request(.CardPrimaryInfo) { (Result) in
            self.handleDecode(result: Result, valueToDecode: completion)
        }
    }
    func GetUserPayment(OrderID: String , completion: @escaping (Result<UserPayment, Error>) -> Void){
        provider.request(.UserPayment(order_id: OrderID)) { (Result) in
            self.handleDecode(result: Result, valueToDecode: completion)
        }
    }
    
    func GetOrderPayment(OrderID: String , completion: @escaping (Result<OrderPayment, Error>) -> Void){
        provider.request(.OrderPayment(order_id: OrderID)) { (Result) in
            self.handleDecode(result: Result, valueToDecode: completion)
        }
    }
    
    func SendInvoiceData(Order_id: String, completion: @escaping (Result<InvoiceData, Error>) -> Void){
        provider.request(.sendInvoice(order_id: Order_id)) { (Result) in
            self.handleDecode(result: Result, valueToDecode: completion)
        }
    }
    func AddFeedback_Data(ProviderID: String, Rating: String, Comment: String, completion: @escaping (Result<AddFeedback, Error>) -> Void){
        provider.request(.addFeedback(provider_id: ProviderID, rating: Rating, comment: Comment)) { (Result) in
            self.handleDecode(result: Result, valueToDecode: completion)
        }
    }
    
    func stripePaymentData(order_id: String,card_id: String, completion: @escaping (Result<stripePayment, Error>) -> Void){
        provider.request(.stripePayment(order_id: order_id,card_id: card_id)) { (Result) in
            self.handleDecode(result: Result, valueToDecode: completion)
        }
    }
    
    func addFavoriteData(provider_id: String, completion: @escaping (Result<addFavorite, Error>) -> Void){
        provider.request(.AddFavorite(provider_id: provider_id)) { (Result) in
            self.handleDecode(result: Result, valueToDecode: completion)
        }
    }
    
    func UpdateOrder_Data(order_id: String, date: String, start_time: String, end_time: String, address_id: String, label_type: String, is_cart: String, addon_id: String, completion: @escaping (Result<UpdateOrder, Error>)-> Void){
        provider.request(.UpdateOrder(order_id: order_id, date: date, start_time: start_time, end_time: end_time, address_id: address_id, label_type: label_type, is_cart: is_cart, addon_id: addon_id)) { (Result) in
            self.handleDecode(result: Result, valueToDecode: completion)
        }
    }
    
    func AddfcmTokenData(device_token: String, completion: @escaping (Result<TokenDetail, Error>) -> Void){
        provider.request(.addFcmToken(device_token: device_token)) { (Result) in
            self.handleDecode(result: Result, valueToDecode: completion)
        }
    }
    
    func addOn_Data(service_id: String, completion: @escaping (Result<AddonData, Error>) -> Void){
        provider.request(.GetAddon(service_id: service_id)) { (Result) in
            self.handleDecode(result: Result, valueToDecode: completion)
        }
    }
    
    func checkMobileNumber(user_type: String, MobileNumber: String, completion: @escaping (Result<checkMobileNumber, Error>) -> Void){
        provider.request(.checkMobileNumber(user_type: user_type, mobile: MobileNumber)) { (Result) in
            self.handleDecode(result: Result, valueToDecode: completion)
        }
    }
}

