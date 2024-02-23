//
//  APICalls.swift
//  Helpy
//
//  Created by mac on 05/11/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import Moya

enum HelpyAPI{
    case login(mobile: String, password: String, email: String, user_type: String, login_type: String, social_id: String)
    case Register(mobile: String, password: String, email: String,social_id: String, user_type :String , login_type : String)
    case UpdatePassword(mobile: String, password: String)
    case UpdateProfile(name: String, mobile: String, address: String, city: String, state: String, avatar: Data, user_type: String,landmark: String, pinCode: String, latitude: String, longitude: String)
    case GetUserProfileData
    case GetParentServices
    case GetSubServices(service_id: String)
    case GetAllAddress
    case AddAddress(mobile: String, address: String, username: String, city: String, state: String, landmark: String, pincode: String, is_primary: String, latitude: String, longitude: String)
    case DeleteAddress(address_id: String)
    case GetAddressDetails(address_id: String)
    case UpdateAddress(address_id: Int, username: String, mobile: String, address: String, city: String, state: String, pincode: String, landmark: String, is_primary: String, latitude: String, longitude: String)
    case GetOrderList
    case OrderBooking(job_type: String, parent_id: String, sub_category_id: String, sub_sub_category_id: String, date: String, start_time: String, end_time: String, address_id: String, job_name: String, job_description: String, label_type: String, is_cart: String, addon_id: String)
    case OrderBookingDetails(booking_id: String)
    case CancelOrder(order_id: String, cancel_reason: String)
    case UserOrderDetails(order_id: String)
    case GetServiceProviderInfo(booking_id: String)
    case GetAllReview(provider_id: String)
    case AddFavorite(provider_id: String)
    case GetPreviousOrders(label_type: String, is_cart: String)
    case GetFavoriteList
    case AddCardDetails(Param: ReqCardDetail?)
    case UpdateCardDetails(param: ReqCardDetail?)
    case GetCardDetails
    case DeleteCard(card_id: String)
    case CardPrimaryInfo
    case UserPayment(order_id: String)
    case OrderPayment(order_id: String)
    case sendInvoice(order_id: String)
    case addFeedback(provider_id: String, rating: String, comment: String)
    case stripePayment(order_id: String,card_id: String)
    case UpdateOrder(order_id: String, date: String, start_time: String, end_time: String, address_id: String, label_type: String, is_cart: String, addon_id: String)
    case addFcmToken(device_token: String)
    case GetAddon(service_id: String)
    case checkMobileNumber(user_type: String, mobile: String)
}

extension HelpyAPI: TargetType{
    var baseURL: URL {
//        return URL(string: "http://3.12.71.5/api/v1/")!
        return URL(string: "https://helpy.alphaved.com/api/v1")!//http://52.14.206.41/api/v1/
    }
    
    var path: String {
        switch self {
        case .login:
            return "login"
        case .Register:
            return "register"
        case .UpdatePassword(mobile: _, password: _):
            return "update-password"
        case .UpdateProfile:
            return "update-user-profile"
        case .GetUserProfileData:
            return "get-user-profile"
        case .GetParentServices:
            return "get-parent-services"
        case .GetSubServices:
            return "get-sub-services"
        case .GetAllAddress:
            return "get-all-address"
        case .AddAddress:
            return "add-address"
        case .DeleteAddress:
            return "delete-address"
        case .GetAddressDetails:
            return "get-address-detail"
        case .UpdateAddress:
            return "update-address"
        case .GetOrderList:
            return "get-user-orders"
        case .OrderBooking:
            return "order-booking"
        case .OrderBookingDetails:
            return "booking-details"
        case .CancelOrder:
            return "order-cancel"
        case .UserOrderDetails:
            return "get-user-order-detail"
        case .GetServiceProviderInfo:
            return "get-service-provider-info"
        case .GetAllReview:
            return "get-all-review"
        case .AddFavorite:
            return "add-favorite"
        case .GetPreviousOrders:
            return "get-previous-order"
        case .GetFavoriteList:
            return "get-favorite-list"
        case .AddCardDetails:
            return "add-card-details"
        case .UpdateCardDetails:
            return "update-card-details"
        case .GetCardDetails:
            return "get-card-details"
        case .DeleteCard:
            return "delete-card"
        case .CardPrimaryInfo:
            return "card-primary-info"
        case .UserPayment:
            return "get-user-payment"
        case .OrderPayment:
            return "get-order-payment"
        case .sendInvoice:
            return "send-invoice-report"
        case .addFeedback:
            return "add-feedback"
        case .stripePayment:
            return "payment"
        case .UpdateOrder:
            return "update-order"
        case .addFcmToken:
            return "add-device-token"
        case .GetAddon:
            return "get-addon"
        case .checkMobileNumber:
            return "check-mobile"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login, .Register, .UpdatePassword, .UpdateProfile, .GetSubServices, .AddAddress, .UpdateAddress, .DeleteAddress, .OrderBooking, .CancelOrder, .AddFavorite, .AddCardDetails, .UpdateCardDetails, .GetCardDetails, .DeleteCard, .CardPrimaryInfo, .UserPayment, .sendInvoice, .addFeedback, .GetPreviousOrders, .stripePayment, .UpdateOrder, .GetAddon, .checkMobileNumber,.OrderPayment,.addFcmToken:
            return .post
            
        case .GetUserProfileData, .GetParentServices, .GetAllAddress, .GetAddressDetails, .GetOrderList, .GetServiceProviderInfo, .OrderBookingDetails, .UserOrderDetails, .GetAllReview,  .GetFavoriteList:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        var parameterData = Data()
        switch self {
        case .login(mobile: let mobile, password: let password, email: let email, user_type: let user_type, login_type: let login_type, social_id: let social_id):
            let authParams = ["mobile" : mobile, "password": password, "user_type": user_type, "login_type" : login_type, "social_id": social_id, "email": email]
            return .requestParameters(parameters: authParams, encoding: URLEncoding.queryString)
        case .Register(mobile: let mobile, password: let password, email: let email, social_id: let social_id, user_type: let user_type, login_type: let login_type):
            var authParams = [String: Any]()
            authParams.removeAll()
            if email == ""{
                authParams = ["mobile" : mobile, "password": password, "user_type": user_type, "login_type" : login_type, "social_id": social_id]
            }else{
                authParams = ["mobile" : mobile, "password": password, "user_type": user_type, "login_type" : login_type, "social_id": social_id, "email": email]
            }
            return .requestParameters(parameters: authParams, encoding: URLEncoding.queryString)
        case .UpdatePassword(mobile: let mobile, password: let password):
            let UpdatePassword_authparams = ["mobile" : mobile, "password": password]
            do {
                parameterData = try JSONSerialization.data(withJSONObject: UpdatePassword_authparams, options: [])
            } catch  {
                print("Parameters not converted with error: \(error)")
            }
        case .UpdateProfile(let name, let mobile, let address, let city, let state, let avatar, let user_type, let landMark, let pinCode, let latitude, let longitude):
            var multipartData = [MultipartFormData]()
                
            multipartData.append(MultipartFormData.init(provider: .data(name.data(using: String.Encoding.utf8) ?? Data()), name: "name"))
            multipartData.append(MultipartFormData.init(provider: .data(mobile.data(using: String.Encoding.utf8) ?? Data()), name: "mobile"))
            multipartData.append(MultipartFormData.init(provider: .data(address.data(using: String.Encoding.utf8) ?? Data()), name: "address"))
            multipartData.append(MultipartFormData.init(provider: .data(city.data(using: String.Encoding.utf8) ?? Data()), name: "city"))
            multipartData.append(MultipartFormData.init(provider: .data(state.data(using: String.Encoding.utf8) ?? Data()), name: "state"))
            multipartData.append(MultipartFormData.init(provider: .data(user_type.data(using: String.Encoding.utf8) ?? Data()), name: "user_type"))
            multipartData.append(MultipartFormData.init(provider: .data(avatar), name: "avatar", fileName: "image",mimeType: "image/jpeg"))
            multipartData.append(MultipartFormData.init(provider: .data(landMark.data(using: String.Encoding.utf8) ?? Data()), name: "landmark"))
            multipartData.append(MultipartFormData.init(provider: .data(pinCode.data(using: String.Encoding.utf8) ?? Data()), name: "pincode"))
            multipartData.append(MultipartFormData.init(provider: .data(latitude.data(using: String.Encoding.utf8) ?? Data()), name: "latitude"))
            multipartData.append(MultipartFormData.init(provider: .data(longitude.data(using: String.Encoding.utf8) ?? Data()), name: "longitude"))
            
            return .uploadMultipart(multipartData)
        case .GetUserProfileData, .GetParentServices, .GetAllAddress, .GetOrderList, .GetFavoriteList, .GetCardDetails, .CardPrimaryInfo:
            return .requestPlain
        case .GetSubServices(service_id: let service_id), .GetAddon(service_id: let service_id):
            let SubServices_authparams = ["service_id" : service_id]
            
            return .requestParameters(parameters: SubServices_authparams, encoding: URLEncoding.queryString)
        case .GetPreviousOrders(label_type: let label_type, is_cart: let is_cart):
            let previousOrder_authParam = ["label_type" : label_type, "is_cart": is_cart]
            return .requestParameters(parameters: previousOrder_authParam, encoding: URLEncoding.queryString)
        case .AddAddress(mobile: let mobile, address: let address, username: let username, city: let city, state: let state, landmark: let landmark, pincode: let pincode, is_primary: let is_primary,let latitude, let longitude):
            let addAddress_authparams = ["mobile" : mobile, "address": address, "username": username, "city": city, "state": state, "landmark": landmark, "pincode": pincode, "is_primary": is_primary,"latitude": latitude,"longitude": longitude] as [String : Any]
            print("add address parametes:\(addAddress_authparams)")
            do {
                parameterData = try JSONSerialization.data(withJSONObject: addAddress_authparams, options: [])
            } catch {
                print("Parameters not converted with error: \(error)")
            }
        case .DeleteAddress(address_id: let address_id):
            let deleteAddress_authparams = ["address_id" : address_id] as [String : Any]
            print("add address parametes:\(deleteAddress_authparams)")
            do {
                parameterData = try JSONSerialization.data(withJSONObject: deleteAddress_authparams, options: [])
            } catch  {
                print("Parameters not converted with error: \(error)")
            }
        case .GetAddressDetails(address_id: let address_id):
            let getAddress_authparams = ["address_id" : address_id] as [String : Any]
            
            return .requestParameters(parameters: getAddress_authparams, encoding: URLEncoding.queryString)
            
        case .UpdateAddress(address_id: let address_id, username: let username, mobile: let mobile, address: let address, city: let city, state: let state, pincode: let pincode, landmark: let landmark, is_primary: let is_primary,let latitude, let longitude):
            
            let updateAddress_authparams = ["address_id" : address_id, "address": address, "username": username, "mobile": mobile, "city": city, "state": state, "landmark": landmark, "pincode": pincode, "is_primary": is_primary,"latitude": latitude,"longitude": longitude] as [String : Any]
            
            print("update address parametes:\(updateAddress_authparams)")
            do {
                parameterData = try JSONSerialization.data(withJSONObject: updateAddress_authparams, options: [])
            } catch {
                print("Parameters not converted with error: \(error)")
            }
        case .OrderBooking(job_type: let job_type, parent_id: let parent_id, sub_category_id: let sub_category_id, sub_sub_category_id: let sub_sub_category_id, date: let date, start_time: let start_time, end_time: let end_time, address_id: let address_id, job_name: let job_name, job_description: let job_description, label_type: let label_type, is_cart: let is_cart, addon_id: let addon_id):
            let orderBooking_authparams = ["job_type" : job_type, "parent_id": parent_id, "sub_category_id": sub_category_id, "sub_sub_category_id": sub_sub_category_id, "date": date, "start_time": start_time, "end_time": end_time, "address_id": address_id, "job_name": job_name, "job_description":job_description, "label_type": label_type, "is_cart": is_cart, "addon_id": addon_id] as [String : Any]
            
            print("Dic: \(orderBooking_authparams)")
            return .requestParameters(parameters: orderBooking_authparams, encoding: URLEncoding.queryString)
        case .OrderBookingDetails(booking_id: let booking_id):
            let getBookingDetails_authparams = ["booking_id" : booking_id] as [String : Any]
            
            return .requestParameters(parameters: getBookingDetails_authparams, encoding: URLEncoding.queryString)
            
        case .CancelOrder(order_id: let order_id, cancel_reason: let cancel_reason):
            let cancelOrder_authparams = ["order_id" : order_id, "cancel_reason": cancel_reason] as [String : Any]
            
            print("order booking parametes:\(cancelOrder_authparams)")
            do {
                parameterData = try JSONSerialization.data(withJSONObject: cancelOrder_authparams, options: [])
            } catch {
                print("Parameters not converted with error: \(error)")
            }
        case .UserOrderDetails(order_id: let order_id),  .UserPayment(order_id: let order_id), .sendInvoice(order_id: let order_id), .OrderPayment(order_id: let order_id):
            let userOrderDetails_authparams = ["order_id" : order_id] as [String : Any]
            
            return .requestParameters(parameters: userOrderDetails_authparams, encoding: URLEncoding.queryString)
            
        case .GetServiceProviderInfo(booking_id: let booking_id):
            let getServiceProviderInfo_authparams = ["booking_id" : booking_id] as [String : Any]
            
            return .requestParameters(parameters: getServiceProviderInfo_authparams, encoding: URLEncoding.queryString)
            
        case .GetAllReview(provider_id: let provider_id):
            let GetAllReview_authparams = ["provider_id" : provider_id] as [String : Any]
            
            return .requestParameters(parameters: GetAllReview_authparams, encoding: URLEncoding.queryString)
            
        case .AddFavorite(provider_id: let provider_id):
            let addFavorite_authparams = ["provider_id" : provider_id] as [String : Any]
            
            print("add favorite parametes:\(addFavorite_authparams)")
            do {
                parameterData = try JSONSerialization.data(withJSONObject: addFavorite_authparams, options: [])
            } catch {
                print("Parameters not converted with error: \(error)")
            }
        case .AddCardDetails(let params):
            let dict = ["payment_type" : params?.paymentType ?? "" ,"card_no" : params?.cardNo ?? "" ,"month" : params?.month ?? "" , "year" : params?.year ?? "", "cvc" : params?.cvc ?? "", "holder_name": params?.holderName ?? "", "is_primary" : params?.isPrimary  ?? ""] as [String : Any]
            return .requestParameters(parameters: dict, encoding: URLEncoding.queryString)
        case .UpdateCardDetails(let params):
            let dicts = ["card_id" : params?.cardID ?? "","payment_type" : params?.paymentType ?? "" ,"card_no" : params?.cardNo ?? "" ,"month" : params?.month ?? "" , "year" : params?.year ?? "", "cvc" : params?.cvc ?? "", "holder_name": params?.holderName ?? "", "is_primary" : params?.isPrimary  ?? ""] as [String : Any]
            return .requestParameters(parameters: dicts, encoding: URLEncoding.queryString)
        case .DeleteCard(card_id: let card_id):
            let Card_authparams = ["card_id" : card_id] as [String : Any]
            
            return .requestParameters(parameters: Card_authparams, encoding: URLEncoding.queryString)
        case .addFeedback(provider_id: let provider_id, rating: let rating, comment: let comment):
            let feedback_authparams = ["provider_id" : provider_id, "rating": rating, "comment": comment] as [String : Any]
            
            return .requestParameters(parameters: feedback_authparams, encoding: URLEncoding.queryString)

        case .stripePayment(let order_id,let card_id):
            let payment_authparams = ["order_id": order_id,"card_id": card_id]
            return .requestParameters(parameters: payment_authparams, encoding: URLEncoding.queryString)
            
        case .addFcmToken(device_token: let device_token):
            let devicetoken_authparams = ["device_token" : device_token]
            return .requestParameters(parameters: devicetoken_authparams, encoding: URLEncoding.queryString)
            
        case .UpdateOrder(order_id: let order_id, date: let date, start_time: let start_time, end_time: let end_time, address_id: let address_id, label_type: let label_type, is_cart: let is_cart, addon_id: let addon_id):
            let EditOrder_Params = ["order_id" : order_id, "date": date, "start_time": start_time, "end_time": end_time, "address_id": address_id, "label_type": label_type, "is_cart": is_cart, "addon_id": addon_id]
            do {
                parameterData = try JSONSerialization.data(withJSONObject: EditOrder_Params, options: [])
            } catch  {
                print("Parameters not converted with error: \(error)")
            }
        case .checkMobileNumber(user_type: let user_type, mobile: let mobile):
            let mobile_param = ["user_type": user_type, "mobile": mobile]
            return .requestParameters(parameters: mobile_param, encoding: URLEncoding.queryString)
        }
        return .requestData(parameterData)
    }
    
    
    var headers: [String : String]? {
        switch  self {
        case .login, .Register, .checkMobileNumber:
            return ["Content-Type" : "application/json"]
        case .UpdatePassword:
            return ["Authorization" : UserDefaults.standard.string(forKey: "AuthToken") ?? "",
                    "Content-Type" : "application/json"]
        case .GetOrderList, .UserOrderDetails, .GetServiceProviderInfo, .GetAllReview, .AddFavorite, .GetPreviousOrders, .DeleteAddress, .UpdateAddress, .GetAddressDetails, .OrderBookingDetails, .GetSubServices, .OrderBooking, .CancelOrder, .GetFavoriteList, .UpdateCardDetails, .DeleteCard, .CardPrimaryInfo, .UserPayment, .OrderPayment, .sendInvoice, .addFeedback, .stripePayment, .UpdateOrder, .GetAddon, .UpdateProfile, .GetUserProfileData, .GetParentServices, .GetCardDetails, .AddCardDetails, .AddAddress, .GetAllAddress,.addFcmToken:
            print("Token: \(UserDefaults.standard.string(forKey: "AuthToken") ?? "")")
            return ["token" : UserDefaults.standard.string(forKey: "AuthToken") ?? "",
                    "Content-Type" : "application/json"]
        }
    }
}
