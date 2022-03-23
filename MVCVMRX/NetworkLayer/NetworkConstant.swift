//
//  NetworkConstant.swift
//  MVCVMRX
//
//  Created by Mac Srtore Egypt on 20/03/2022.
//

import Foundation
import Alamofire
struct Constants {
    
    //The API's base URL
    static let baseUrl = "https://staging.sary.to/api/"
    static let Token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjgxNTEyLCJ1c2VyX3Bob25lIjoiOTY2NTkxMTIyMzM0In0.phRQP0e5yQrCVfZiN4YlkI8NhXRyqa1fGRx5rvrEv0o"
    static var applanuage = "en"


    enum HttpHeaderField: String {
        case authorization
        case appVersion
        case acceptLanguage
        case deviceType
        case Platform

       func HttpHeader() ->  String {
           switch self {
           case .authorization:
               return "token eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjgxNTEyLCJ1c2VyX3Bob25lIjoiOTY2NTkxMTIyMzM0In0.phRQP0e5yQrCVfZiN4YlkI8NhXRyqa1fGRx5rvrEv0o"
           case .appVersion:
               return "5.5.0.0.0"
           case .acceptLanguage:
               return Constants.applanuage
           case .deviceType:
               return "ios"
           case .Platform:
               return "FLAGSHIP"
           }
       }
   }
    
    //The content type (JSON)
    enum ContentType: String {
        case json = "application/json"
    }
}

