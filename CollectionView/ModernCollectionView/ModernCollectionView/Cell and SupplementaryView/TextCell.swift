//
//  TextCell.swift
//  ModernCollectionView
//
//  Created by Nick on 2023/08/03.
//

import UIKit

final class TextCell: UICollectionViewCell {
    
    // MARK: - Property
    
    static let id = "textCell"
    private let label = UILabel()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureHierachy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemnted")
    }
}

// MARK: - Function

extension TextCell {
    
    private func configureUI() {
        self.contentView.backgroundColor = .green
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        self.label.textAlignment = .center
        self.label.font = UIFont.preferredFont(forTextStyle: .title1)
    }
    
    private func configureHierachy() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        contentView.addSubview(label)
        let inset = CGFloat(10)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset)
        ])
    }
    
    internal func configureComponent(with title: String) {
        label.text = title
    }
    
}

