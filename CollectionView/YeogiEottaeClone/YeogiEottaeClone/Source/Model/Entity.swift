//
//  Model.swift
//  YeogiEottaeClone
//
//  Created by Nick on 2023/07/11.
//

import Foundation

// MARK: - Welcome
struct Entity: Decodable {
    let code: Int
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Decodable {
    let id: Int
    let name: String
    let type: Int
    let typeLabel: MemberTypeLabelEnum
    let moduleCount: Int
    let modules: [Module]
    let fallback: Bool
}
