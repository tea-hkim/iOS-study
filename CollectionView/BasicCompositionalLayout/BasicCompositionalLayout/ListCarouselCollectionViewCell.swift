//
//  ListCarouselCollectionViewCell.swift
//  BasicCompositionalLayout
//
//  Created by 김태호 on 2023/06/18.
//

import UIKit

class ListCarouselCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let id = "ListCarouselCollectionViewCell"
    private let mainImage = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Functions
    
    private func configureUI() {
        setConstraint()
    }
    
    private func setConstraint() {
        [mainImage, titleLabel, subtitleLabel].forEach {
            addSubview($0)
        }
        
        mainImage.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.width.equalTo(60)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.trailing.top.equalToSuperview()
            make.leading.equalTo(mainImage.snp.trailing).offset(8)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalToSuperview()
        }
    }
    
    func configComponents(imageUrl: String, title: String, subtitle: String?) {
        mainImage.kf.setImage(with: URL(string: imageUrl))
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
    
}
