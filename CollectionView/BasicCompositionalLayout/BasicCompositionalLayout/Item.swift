//
//  Item.swift
//  BasicCompositionalLayout
//
//  Created by 김태호 on 2023/06/17.
//

import Foundation

//MARK: - Section & Item

struct Section: Hashable {
    let id: String
}

enum Item: Hashable {
    case banner(HomeItem)
    case normalCarousel(HomeItem)
    case listCarousel(HomeItem)
}

struct HomeItem: Hashable {
    let title: String
    let subTitle: String?
    let imageUrl: String
}
