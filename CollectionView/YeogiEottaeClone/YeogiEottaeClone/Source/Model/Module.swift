//
//  Module.swift
//  YeogiEottaeClone
//
//  Created by Nick on 2023/07/24.
//

import Foundation

// MARK: - Module
struct Module: Decodable {
    let name: String
    let typeLabel: String?
    let components: [Component]?
}
