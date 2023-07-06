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
    
    private let LaunchImageUrl: [String] = [
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
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) { [weak self] in
            guard let self else { return }
            self.activityIndicator.stopAnimating()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) { [weak self] in
            guard let self else { return }
            self.activityIndicator.startAnimating()
            changeImage()
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) { [weak self] in
            guard let self else { return }
            self.activityIndicator.stopAnimating()
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
    
    func changeImage() {
        let imageArray = ["splash_1.jpeg","splash_2.jpeg","splash_3.jpeg"]
        
        let RandomNumber = Int(arc4random_uniform(UInt32(imageArray.count)))
        let image = UIImage.init(named: "\(imageArray[RandomNumber])")
        let newImageView = UIImageView.init(image: image)
        newImageView.frame = UIScreen.main.bounds
        
        view.addSubview(newImageView)
        view.bringSubviewToFront(newImageView)
        view.bringSubviewToFront(activityIndicator)
    }

}
