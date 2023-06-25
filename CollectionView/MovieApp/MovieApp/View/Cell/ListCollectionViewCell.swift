//
//  ListCollectionViewCell.swift
//  MovieApp
//
//  Created by 김태호 on 2023/06/24.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Property
    
    static let id = "ListCollectionViewCell"
    
    // MARK: - UI Property
    
    private let image: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    private let releaseLabel: UILabel = {
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
        [image, titleLabel, releaseLabel].forEach { addSubview($0) }
        
        image.snp.makeConstraints { make in
            make.verticalEdges.leading.equalToSuperview()
            make.width.equalTo(140)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(14)
            make.leading.equalTo(image.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(8)
        }
        
        releaseLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalToSuperview().inset(8)
        }

    }
    
    func configureComponents(imageUrl: String?, title: String?, releaseDate: String?) {
        // TODO: - Error 처리하기
        guard let imageUrl else { return }
        image.kf.setImage(with: URL(string: imageUrl))
        titleLabel.text = title
        releaseLabel.text = releaseDate
    }
}
