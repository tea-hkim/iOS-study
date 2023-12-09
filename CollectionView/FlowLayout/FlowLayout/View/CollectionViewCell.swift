//
//  CollectionViewCell.swift
//  FlowLayout
//
//  Created by 김태호 on 12/9/23.
//

import UIKit

final class CollectionViewCell: UICollectionViewCell {
    static let reuseableIdentifier = String(describing: CollectionViewCell.self)
    @IBOutlet weak var emojiLabel: UILabel!
    
}
