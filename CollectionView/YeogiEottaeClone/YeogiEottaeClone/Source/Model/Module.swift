//
//  Module.swift
//  YeogiEottaeClone
//
//  Created by Nick on 2023/07/24.
//

import Foundation

// MARK: - Module
struct Module: Decodable {
    let id, seq: Int
    let name: String
    let type: Int
    let typeLabel: String?
    let components: [Component]?
}
