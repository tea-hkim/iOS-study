//
//  LaunchScreenViewController.swift
//  YeogiEottaeClone
//
//  Created by Nick on 2023/07/04.
//

import UIKit

final class LaunchScreenViewController: UIViewController {
    
    // MARK: - Properties
    
    private var imageView = UIImageView()
    private let activityIndicator = UIActivityIndicatorView()
    
    private let imageUrlList: [String] = [
        "https://image.goodchoice.kr/images/app/splash/splash_230602_1.jpg",
        "https://image.goodchoice.kr/images/app/splash/splash_230602_2.jpg",
        "https://image.goodchoice.kr/images/app/splash/splash_230602_4.jpg"
    ]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setConstraints()
        
        // indicator Loading
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
    
    private func configureUI() {
        imageView.image = UIImage(named: "LaunchImage")
        imageView.contentMode = .scaleAspectFill
        activityIndicator.color = .systemPink
    }
    
    private func setConstraints() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityIndicator.heightAnchor.constraint(equalToConstant: 25),
            activityIndicator.widthAnchor.constraint(equalToConstant: 25),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    func getImage() {
        let randomNumber = Int(arc4random_uniform(UInt32(imageUrlList.count)))
        let randomImageUrl = imageUrlList[randomNumber]
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
