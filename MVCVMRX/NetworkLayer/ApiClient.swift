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
            newtask()
            
            let request = AF.request(urlConvertible).responseDecodable { (response: DataResponse<T,AFError>) in
                print(response.data.map { String(decoding: $0, as: UTF8.self) } ?? "No data.")
                print(response.response?.allHeaderFields)
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
    
    private static func newtask(){
    var semaphore = DispatchSemaphore (value: 0)
    var request = URLRequest(url: URL(string: "http://staging.sary.to/api/baskets/325514/catalog/")!,timeoutInterval: Double.infinity)
//    request.addValue("ios", forHTTPHeaderField: "Device-Type")
//    request.addValue("5.5.0.0.0", forHTTPHeaderField: "App-Version")
//    request.addValue("en", forHTTPHeaderField: "Accept-Language")
//    request.addValue("FLAGSHIP", forHTTPHeaderField: "Platform")
//    request.addValue("Token eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjgxNTEyLCJ1c2VyX3Bob25lIjoiOTY2NTkxMTIyMzM0In0.phRQP0e5yQrCVfZiN4YlkI8NhXRyqa1fGRx5rvrEv0o", forHTTPHeaderField: "Authorization")
        
        let headers:HTTPHeaders = [
                    "Authorization": "Token eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjgxNTEyLCJ1c2VyX3Bob25lIjoiOTY2NTkxMTIyMzM0In0.phRQP0e5yQrCVfZiN4YlkI8NhXRyqa1fGRx5rvrEv0o"
                ]
        request.headers = headers

    request.httpMethod = "GET"

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      guard let data = data else {
        print(String(describing: error))
        semaphore.signal()
        return
      }
      print(String(data: data, encoding: .utf8)!)
      semaphore.signal()
    }

    task.resume()
    semaphore.wait()
        
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
