//
//  CategoryDomesticCollectionViewCell.swift
//  YeogiEottaeClone
//
//  Created by Nick on 2023/07/17.
//

import UIKit
import SnapKit
import Then

class CategoryDomesticCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Property
    
    static let id = "CategoryDomesticCollectionViewCell"
    
    private let imageView = UIImageView().then {
        $0.layer.cornerRadius = 5
        $0.layer.masksToBounds = true
    }
    
    private let titleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierachy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierachy() {
        [imageView, titleLabel].forEach {
            addSubview($0)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    private func configureComponent(imageUrlString: String?, title: String?) {
        // TODO: Error 처리하기
        guard let imageUrlString else { return }
        guard let imageUrl = URL(string: imageUrlString) else { return }
        imageView.load(url: imageUrl)
        titleLabel.text = title
    }
    
}
