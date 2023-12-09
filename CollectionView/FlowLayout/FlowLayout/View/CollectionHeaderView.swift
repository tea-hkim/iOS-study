//
//  CollectionHeaderView.swift
//  FlowLayout
//
//  Created by 김태호 on 12/9/23.
//

import UIKit

final class CollectionHeaderView: UICollectionReusableView {
    static let reusableIdentifier = String(describing: CollectionHeaderView.self)
    @IBOutlet weak var headerTitleLabel: UILabel!
}
