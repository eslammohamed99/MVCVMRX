//
//  ApiRequest.swift
//  MVCVMRX
//
//  Created by Mac Srtore Egypt on 20/03/2022.
//

import Foundation
import Alamofire



enum ApiRouter: URLRequestConvertible {
    
    case getBanner
    case catalog
    
    
    private var method: HTTPMethod {
        switch self {
        case .getBanner: return .get
        case .catalog: return .get
        }
    }
    
//    private var headers: HTTPHeaders {
//        return [
//        "Device-Type": Constants.HttpHeaderField.deviceType.HttpHeader(),
//      "App-Version": Constants.HttpHeaderField.appVersion.HttpHeader(),
//      "Accept-Language": Constants.HttpHeaderField.acceptLanguage.HttpHeader(),
//      "Platform": Constants.HttpHeaderField.Platform.HttpHeader(),
//      "Authorization": Constants.HttpHeaderField.authorization.HttpHeader()
//    ]
//    }
    
    
    //MARK: - HttpMethod
    
    
    //MARK: - Path
    //The path is the part following the base url
    private var path: String {
        switch self {
        case .getBanner:
            return "v2.5.1/baskets/325514/banners"
        case .catalog:
            return "baskets/325514/catalog/"
    
        }
    }
    
    private var parameters: Parameters? {
        switch self {
        case .getBanner:
            return nil
        case .catalog:
            return nil
        }
    }
}

extension ApiRouter{
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.baseUrl.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        //Http method
        urlRequest.httpMethod = method.rawValue

//        urlRequest.setValue(Constants.HttpHeaderField.deviceType.HttpHeader(), forHTTPHeaderField: "Device-Type")
//        urlRequest.setValue(Constants.HttpHeaderField.appVersion.HttpHeader(), forHTTPHeaderField: "App-Version")
//        urlRequest.setValue(Constants.HttpHeaderField.acceptLanguage.HttpHeader(), forHTTPHeaderField: "Accept-Language")
//        urlRequest.setValue(Constants.HttpHeaderField.Platform.HttpHeader(), forHTTPHeaderField: "Platform")
//        urlRequest.setValue(Constants.HttpHeaderField.authorization.HttpHeader(), forHTTPHeaderField: "Authorization")
        
        
        
        //Encoding
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return JSONEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        urlRequest.addValue("ios", forHTTPHeaderField: "Device-Type")
        urlRequest.addValue("5.5.0.0.0", forHTTPHeaderField: "App-Version")
        urlRequest.addValue("en", forHTTPHeaderField: "Accept-Language")
        urlRequest.addValue("FLAGSHIP", forHTTPHeaderField: "Platform")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("Token eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjgxNTEyLCJ1c2VyX3Bob25lIjoiOTY2NTkxMTIyMzM0In0.phRQP0e5yQrCVfZiN4YlkI8NhXRyqa1fGRx5rvrEv0o", forHTTPHeaderField: "Authorization")
        
        return try encoding.encode(urlRequest, with: parameters)
    }
}
