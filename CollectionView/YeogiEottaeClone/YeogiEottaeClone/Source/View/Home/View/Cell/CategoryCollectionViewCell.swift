//
//  CategoryDomesticCollectionViewCell.swift
//  YeogiEottaeClone
//
//  Created by Nick on 2023/07/17.
//

import UIKit
import SnapKit
import Then
import Lottie

class CategoryCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Property
    
    static let id = "CategoryCollectionViewCell"
    private var animationView: LottieAnimationView?
    
    private let imageView = UIImageView().then {
        $0.layer.cornerRadius = 5
        $0.layer.masksToBounds = true
    }
    
    private let titleLabel = UILabel().then {
        $0.alpha = 0.9
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 12, weight: .medium)
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
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.width.equalTo(35)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    private func addAnimationView(url: URL) {
        animationView = LottieAnimationView(url: url) {[weak self] _ in
            guard let self = self, let animationView = animationView else { return }
            animationView.loopMode = .loop
            addSubview(animationView)
            animationView.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.centerX.equalToSuperview()
                make.height.width.equalTo(35)
            }
            self.animationView?.play() { _ in
                print("animation play")
            }
        }
    }
    
    internal func configureComponent(imageUrlString: String?, title: String?) {
        // TODO: Error 처리하기
        guard let imageUrlString else { return }
        guard let imageUrl = URL(string: imageUrlString) else { return }
        if imageUrlString.contains(".json") {
            imageView.isHidden = true
            addAnimationView(url: imageUrl)
        } else if imageUrlString.contains(".svg") {
            imageView.loadSVG(url: imageUrl)
        } else {
            imageView.load(url: imageUrl)
        }
        titleLabel.text = title
    }
    
}
