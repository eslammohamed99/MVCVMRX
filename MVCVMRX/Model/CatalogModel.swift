//
//  CatalogModel.swift
//  MVCVMRX
//
//  Created by Mac Srtore Egypt on 21/03/2022.
//

import Foundation
struct catalogModel : Codable {
    let catalogResult : [CatalogResult]?
    let message : String?
    let status : Bool?

    enum CodingKeys: String, CodingKey {

        case catalogResult = "result"
        case message = "message"
        case status = "status"
    }
}
struct CatalogResult : Codable {
    let id : Int?
    let metadata : Metadata?
    let title : String?
    let subtitle : String?
    let data : [catalogData]?
    let data_type : String?
    let show_title : Bool?
    let ui_type : String?
    let row_count : Int?
    let show_more_enabled : Bool?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case metadata = "metadata"
        case title = "title"
        case subtitle = "subtitle"
        case data = "data"
        case data_type = "data_type"
        case show_title = "show_title"
        case ui_type = "ui_type"
        case row_count = "row_count"
        case show_more_enabled = "show_more_enabled"
    }
}
struct Metadata : Codable {
    let title : String?
    let sub_title : String?

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case sub_title = "sub_title"
    }


}
struct catalogData : Codable {
    let metadata : Metadata?
    let group_id : Int?
    let name : String?
    let image : String?
    let cover : String?
    let header : String?

    enum CodingKeys: String, CodingKey {

        case metadata = "metadata"
        case group_id = "group_id"
        case name = "name"
        case image = "image"
        case cover = "cover"
        case header = "header"
    }
}
