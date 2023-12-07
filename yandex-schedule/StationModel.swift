//
//  StationModel.swift
//  yandex-schedule
//
//  Created by Nikolai  on 07.12.2023.
//

import Foundation

//// MARK: - Station
//struct Station: Decodable, Equatable {
//    let items: [Item]
//}
//
//// MARK: - Item
//struct Item: Decodable, Equatable {
//    let objID: Int
//    let fullTitle, title, slug: String
//
//    let country, popularTitle, stationType, pointKey: String
//
//    enum CodingKeys: String, CodingKey {
//        case objID = "objId"
//        case objType
//        case fullTitle = "full_title"
//        case title, slug, settlement, region, country
//        case popularTitle = "popular_title"
//        case stationType = "station_type"
//        case pointKey = "point_key"
//    }
//}

//// MARK: - Station
//struct Station: Codable, Equatable {
//    let items: [Item]
//}
//
//// MARK: - Item
//struct Item: Codable, Equatable {
//    let fullTitle: String
//    let pointKey: String
//}


// MARK: - Station
struct Station: Codable, Equatable {
    let items: [Item]
}

// MARK: - Item
struct Item: Codable, Equatable {
    let objID: Int
    let objType: ObjType
    let fullTitle, title, slug: String
    let settlement: String
    let region: String
    let country, popularTitle, stationType, pointKey: String

    enum CodingKeys: String, CodingKey {
        case objID = "objId"
        case objType
        case fullTitle = "full_title"
        case title, slug, settlement, region, country
        case popularTitle = "popular_title"
        case stationType = "station_type"
        case pointKey = "point_key"
    }
}

enum ObjType: String, Codable {
    case settlement = "settlement"
    case station = "station"
}

