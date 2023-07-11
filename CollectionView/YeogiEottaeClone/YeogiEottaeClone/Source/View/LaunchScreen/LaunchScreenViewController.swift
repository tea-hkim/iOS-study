//
//  LaunchScreenViewController.swift
//  YeogiEottaeClone
//
//  Created by Nick on 2023/07/04.
//

import UIKit
import SnapKit
import Then

final class LaunchScreenViewController: UIViewController {
    
    // MARK: - Properties
    
    private var imageView = UIImageView().then {
        $0.image = UIImage(named: "LaunchImage")
        $0.contentMode = .scaleAspectFill
    }
    private let activityIndicator = UIActivityIndicatorView().then {
        $0.color = .systemPink
    }
    
    private let imageUrlStringList: [String] = [
        "https://image.goodchoice.kr/images/app/splash/splash_230602_1.jpg",
        "https://image.goodchoice.kr/images/app/splash/splash_230602_2.jpg",
        "https://image.goodchoice.kr/images/app/splash/splash_230602_4.jpg"
    ]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
        
        activityIndicator.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) { [weak self] in
            self?.activityIndicator.stopAnimating()
            guard let self else { return }
            getImage()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        activityIndicator.stopAnimating()
    }
    
    // MARK: - Fucntions
    
    private func setConstraints() {
        view.addSubview(imageView)
        view.addSubview(activityIndicator)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.height.width.equalTo(25)
            make.center.equalToSuperview()
        }
        
    }
    
    func getImage() {
        let randomNumber = Int.random(in: 0..<imageUrlStringList.count)
        let randomImageUrl = imageUrlStringList[randomNumber]
        guard let url = URL(string: randomImageUrl) else { return }
        
        DispatchQueue.global().async {[weak self] in
            guard let self else { return }
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.activityIndicator.startAnimating()
                        self.imageView.image = image
                    }
                }
            }
        }
    }

}
