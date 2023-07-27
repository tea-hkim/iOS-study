//
//  Component.swift
//  YeogiEottaeClone
//
//  Created by Nick on 2023/07/24.
//

import Foundation

// MARK: - Component
struct Component: Decodable, Hashable {
    let id, seq: Int
    let name: String
    let image: Image?
    let text: API?
    let typeLabel: String?
    let badgeImage, rvp, api: API?
    let product: Product?
    let titleText, textProduct: API?
}

// MARK: - API
struct API: Decodable, Hashable {
    let id, seq: Int
    let contents: [Content]
}

// MARK: - APIContent
struct Content: Decodable, Hashable {
    let id, seq: Int
    let value: String?
    let typeLabel: TypeLabel
    let landingValue: String?
    let section: Section?
    let pgMetaType: PGMetaType?
}

enum PGMetaType: String, Codable {
    case category = "category"
    case promotion = "promotion"
    case recent = "recent"
    case theme = "theme"
    case timeevent = "timeevent"
}

enum Section: String, Codable {
    case categorySection = "category_sec"
    case promotionSection = "promotion_sec"
    case recentSection = "recent_sec"
    case themeSection = "theme_sec"
    case timeeventSection = "timeevent_sec"
}

enum TypeLabel: String, Codable {
    case appScheme = "appScheme"
    case noConnection = "연결 없음"
}

enum ViewTypeLabel: String, Decodable {
    case button = "button"
    case html = "html"
    case imageBanner = "imageBanner"
    case rvp = "RVP"
    case textBanner = "textBanner"
    case textProduct = "textProduct"
}

// MARK: - Image
struct Image: Decodable, Hashable {
    let imageRatio: ImageRatio?
    let viewTypeLabel: ViewTypeLabel
    let contents: [Content]
    
    enum ImageRatio: String, Codable {
        case the191 = "19:1"
        case the51 = "5:1"
        case the52 = "5:2"
        case the53 = "5:3"
        case the55 = "5:5"
    }
}


// MARK: - Product
struct Product: Decodable, Hashable {
    let id, seq, viewType: Int
    let viewTypeLabel: String
    let contents: [ProductContent]
}

// MARK: - ProductContent
struct ProductContent: Decodable, Hashable {
    let id, seq, type: Int
    let typeLabel: TypeLabel
    let landingValue: String
}
