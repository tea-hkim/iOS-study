//
//  BannerCollectionViewCell.swift
//  BasicCompositionalLayout
//
//  Created by 김태호 on 2023/06/17.
//

import UIKit
import SnapKit
import Kingfisher

class BannerCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let id = "BannerCollectionViewCell"
    
    private let titleLabel = UILabel()
    private let backgroundImage = UIImageView()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Functions
    
    private func configureUI() {
        setAttribute()
        setConstraints()
    }
    
    private func setAttribute() {
        backgroundImage.backgroundColor = .yellow
    }
    
    private func setConstraints() {
        [backgroundImage, titleLabel].forEach { addSubview($0) }
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    internal func configComponents(title: String, imageUrl: String) {
        titleLabel.text = title
        let url = URL(string: imageUrl)
        backgroundImage.kf.setImage(with: url)
    }
    
}
