//
//  NormalCollectionViewCell.swift
//  MovieApp
//
//  Created by Nick on 2023/06/23.
//

import UIKit

import SnapKit
import Kingfisher

class NormalCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Property
    
    static let id = "NormalCollectionViewCell"
    
    // MARK: - UI Property
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 5
        image.layer.masksToBounds = true
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let reviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstarints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Function
    
    private func setConstarints() {
        [image, titleLabel, reviewLabel, descriptionLabel].forEach {
            addSubview($0)
        }
        
        image.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(140)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview()
        }
        
        reviewLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(reviewLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    // MARK: - Function
    
    func configureComponents(imageUrl: String?, title: String?, review: String?, description: String?) {
        // TODO: - Error 처리하기
        guard let imageUrl else { return }
        image.kf.setImage(with: URL(string: imageUrl))
        titleLabel.text = title
        reviewLabel.text = review
        descriptionLabel.text = description
    }
    
}
