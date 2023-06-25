//
//  BigImageCollectionViewCell.swift
//  MovieApp
//
//  Created by 김태호 on 2023/06/24.
//

import UIKit

class BigImageCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Property
    
    static let id = "BigImageCollectionViewCell"
    
    // MARK: - UI Property
    
    private let posterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        return imageView
    }()
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
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
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Function
    
    private func setConstraints() {
        [posterImage, stackView].forEach { addSubview($0) }
        [titleLabel, reviewLabel, descriptionLabel].forEach { stackView.addArrangedSubview($0) }
        
        posterImage.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(500)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(posterImage.snp.bottom).offset(12)
            make.horizontalEdges.bottom.equalToSuperview().inset(14)
        }
    }
    
    func configureComponents(imageUrl: String?, title: String?, review: String?, description: String?) {
        // TODO: - Error 처리하기
        guard let imageUrl else { return }
        posterImage.kf.setImage(with: URL(string: imageUrl))
        titleLabel.text = title
        reviewLabel.text = review
        descriptionLabel.text = description
    }
    
}
