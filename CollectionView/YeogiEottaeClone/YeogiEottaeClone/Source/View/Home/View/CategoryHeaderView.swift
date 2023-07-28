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
        configureHierachy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierachy() {
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(80)
        }
    }
    
    internal func configureComponent(imageUrlString: String) {
        // TODO: 이미지를 불러오지 못한 경우 에러 처리하기
        guard let imageUrl = URL(string: imageUrlString) else { return }
        imageView.load(url: imageUrl)
    }
    
}
