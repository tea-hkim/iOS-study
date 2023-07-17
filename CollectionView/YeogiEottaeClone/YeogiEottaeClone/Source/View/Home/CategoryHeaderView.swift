//
//  CategoryHeaderView.swift
//  YeogiEottaeClone
//
//  Created by Nick on 2023/07/17.
//

import UIKit

class CategoryHeaderView: UICollectionReusableView {
        
    // MARK: - Property
    
    static let id = "CategoryHeaderView"
    private let imageView = UIImageView()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func configureComponent(imageUrlString: String?) {
        guard let imageUrlString else { return }
        guard let imageUrl = URL(string: imageUrlString) else { return }
        imageView.load(url: imageUrl)
    }
    
}
