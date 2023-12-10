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
    
    var isEditing: Bool = false
    
    override var isSelected: Bool {
        didSet {
            if isEditing {
                contentView.backgroundColor = isSelected ? .gray.withAlphaComponent(0.5) : .white
            } else {
                contentView.backgroundColor = .white
            }
        }
    }
    
}
