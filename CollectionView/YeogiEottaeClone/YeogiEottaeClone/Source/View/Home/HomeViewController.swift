//
//  HomeViewController.swift
//  YeogiEottaeClone
//
//  Created by Nick on 2023/06/26.
//

import UIKit

enum CollectionViewSection: Hashable {
    case categoryDomestic(UIImage)
    case categoryOversea(UIImage)
    case bannerMarketing
    case couponEvent
    case hotelSale(String)
    case poularPansion(String)
    case city(String)
    case ticketPlusHotel(String)
}

enum CollectionViewItem: Hashable {
    case categroy
    case cityCategory
    case bannerImage
    case iconList
}

class HomeViewController: UIViewController {
    
    // MARK: - UI Property
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    private lazy var titleImage = UIImageView()
    
    // MARK: - Property
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureHierachy()
        dataTask()
    }
    
    // MARK: - UI Function
    
    private func configureHierachy() {
        view.addSubview(titleImage)
        
        titleImage.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(140)
        }
    }
    
    // MARK: - Functions
    
    private func dataTask() {
        let urlString = "http://192.168.0.107:3000/home"
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            URLSession.shared.dataTask(with: request) {[weak self] data, response, error in
                guard let self else { return }
                if let error = error {
                    return print("⚠️URL Error", error.localizedDescription)
                }
                
                if let jsonData = data {
                    do {
                        var set: Set<String> = []
                        let someData = try JSONDecoder().decode(Entity.self, from: jsonData)
                        let componentsList = someData.data.modules.compactMap { $0.components }
                        componentsList.forEach({ componentList in
                            componentList.compactMap {
                                guard let typeLabel = $0.typeLabel else { return }
                                set.insert(typeLabel)
                            }
                        })
                        print(set)
                        
                    } catch {
                        return print("⚠️JSON Decoding Error ", error.localizedDescription)
                    }
                }
            }.resume()
        }
    }

}

// MARK: - Configure CollectionView

extension HomeViewController {
    
    private func configureDataSource() {
        
    }
    
}


// 출처 : https://www.hackingwithswift.com/example-code/uikit/how-to-load-a-remote-image-url-into-uiimageview

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
