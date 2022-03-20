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
    
    private var headers: HTTPHeaders {
        return [
            "Device-Type": Constants.HttpHeaderField.deviceType.rawValue,
      "App-Version": Constants.HttpHeaderField.appVersion.rawValue,
      "Accept-Language": Constants.HttpHeaderField.acceptLanguage.rawValue,
      "Platform": Constants.HttpHeaderField.Platform.rawValue,
      "Authorization": Constants.HttpHeaderField.authorization.rawValue
    ]
    }
    
    
    //MARK: - HttpMethod
   
    
    //MARK: - Path
    //The path is the part following the base url
    private var path: String {
        switch self {
        case .getBanner:
            return "v2.5.1/baskets/325514/banners"
        case .catalog:
            return "baskets/325514/catalog"
    
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


        //Encoding
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        print(try encoding.encode(urlRequest, with: parameters))
        return try encoding.encode(urlRequest, with: parameters)
    }
}
