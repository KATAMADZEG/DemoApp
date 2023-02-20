//
//  ImageDetailModel.swift
//  DemoApp
//
//  Created by Giorgi Katamadze on 2/20/23.
//

import Foundation


struct ImageDetailModel:Codable {
    var imageInfo : ImageInfoModel?
    var userInfo  : UserInfo?
}

struct ImageInfoModel:Codable {
    var key        : String?
    var previewURL :String?
    var imageSize  : Int?
    var type       : String?
    var tags       : String?
}

struct UserInfo:Codable {
    var key         : String?
    var views       : Int?
    var downloads   : Int?
    var comments    : Int?
    var likes       : Int?
}
