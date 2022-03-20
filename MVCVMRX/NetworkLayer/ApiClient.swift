//
//  ApiClient.swift
//  MVCVMRX
//
//  Created by Mac Srtore Egypt on 20/03/2022.
//

import Alamofire
import RxSwift
import Foundation

class APIClient {
private static func request<T: Codable> (_ urlConvertible: URLRequestConvertible) -> Observable<T> {
        return Observable<T>.create { observer in
            let request = AF.request(urlConvertible).responseDecodable { (response: DataResponse<T,AFError>) in
                switch response.result {
                case .success(let value):
                    observer.onNext(value)
                    observer.onCompleted()
                case .failure(let error):
                    switch response.response?.statusCode {
                    case 403:
                        observer.onError(ApiError.forbidden)
                    case 404:
                        observer.onError(ApiError.notFound)
                    case 409:
                        observer.onError(ApiError.conflict)
                    case 500:
                        observer.onError(ApiError.internalServerError)
                    default:
                        observer.onError(error)
                    }
                }
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
}

enum ApiError: Error {
    case forbidden              //Status code 403
    case notFound               //Status code 404
    case conflict               //Status code 409
    case internalServerError    //Status code 500
}

extension APIClient{
    static func getBannerData() -> Observable<BannerModel> {
        return request(ApiRouter.getBanner)
        }
    
    static func getCatalogData() -> Observable<catalogModel> {
        return request(ApiRouter.catalog)
        }
    
    
}
