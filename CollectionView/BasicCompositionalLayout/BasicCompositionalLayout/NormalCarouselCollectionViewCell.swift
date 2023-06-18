//
//  NormalCarouselCollectionViewCell.swift
//  BasicCompositionalLayout
//
//  Created by 김태호 on 2023/06/18.
//

import UIKit

class NormalCarouselCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let id = "NormalCarouselCollectionViewCell"
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
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(80)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(mainImage.snp.bottom).offset(8)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
    }
    
    func configComponents(imageUrl: String, title: String, subtitle: String?) {
        mainImage.kf.setImage(with: URL(string: imageUrl))
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
    
}
