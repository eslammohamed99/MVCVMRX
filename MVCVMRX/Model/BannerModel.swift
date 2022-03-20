//
//  BannerModel.swift
//  MVCVMRX
//
//  Created by Mac Srtore Egypt on 21/03/2022.
//

import Foundation

struct BannerModel : Codable {
    let bannerResult : [bannerResult]?
    let status : Bool?

    enum CodingKeys: String, CodingKey {

        case bannerResult = "result"
        case status = "status"
    }

}
struct bannerResult : Codable {
    let id : Int?
    let metadata : Metadata?
    let title : String?
    let description : String?
    let button_text : String?
    let expiry_status : Bool?
    let created_at : String?
    let start_date : String?
    let expiry_date : String?
    let image : String?
    let photo : String?
    let promo_code : String?
    let priority : Int?
    let link : String?
    let level : String?
    let is_available : Bool?
    let branches : [String]?
    let cities : [Int]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case metadata = "metadata"
        case title = "title"
        case description = "description"
        case button_text = "button_text"
        case expiry_status = "expiry_status"
        case created_at = "created_at"
        case start_date = "start_date"
        case expiry_date = "expiry_date"
        case image = "image"
        case photo = "photo"
        case promo_code = "promo_code"
        case priority = "priority"
        case link = "link"
        case level = "level"
        case is_available = "is_available"
        case branches = "branches"
        case cities = "cities"
    }
}
