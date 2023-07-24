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
    case categroy(Component)
    case cityCategory
    case bannerImage
    case iconList
}

class HomeViewController: UIViewController {
    
    // MARK: - UI Property
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    private lazy var titleImage = UIImageView()
    
    // MARK: - Property
    
    private var dataSource: UICollectionViewDiffableDataSource<CollectionViewSection, CollectionViewItem>?
    private var currentSnapshot: NSDiffableDataSourceSnapshot<CollectionViewSection, CollectionViewItem>?
    
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
                        var componentTypeLabelset: Set<String> = []
                        var moduleTypeLabelset: Set<String> = []
                        let someData = try JSONDecoder().decode(Entity.self, from: jsonData)
                        print(someData.data.modules[2].components?.forEach {
                            print($0.name)
                            if let imageUrl = $0.image?.contents[0].value {
                                print(imageUrl)
                            } else {
                                print($0)
                            }
                            
                        } )
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
    
    func createLayout() -> UICollectionViewLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 14
        
        return UICollectionViewCompositionalLayout {[weak self] sectionIndex, _ in
            let section = self?.dataSource?.sectionIdentifier(for: sectionIndex)
            switch section {
            case .categoryDomestic:
                return self?.createCategorySection()
            default:
                return self?.createCategorySection()
            }
        }
    }
    
    private func createCategorySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(320))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 4)
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<CollectionViewSection, CollectionViewItem>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .categroy(let component):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.id, for: indexPath) as? CategoryCollectionViewCell
                cell?.configureComponent(imageUrlString: component.image?.contents[0].value, title: component.name)
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.id, for: indexPath) as? CategoryCollectionViewCell
                return cell
            }
        })
        
        currentSnapshot = NSDiffableDataSourceSnapshot<CollectionViewSection, CollectionViewItem>()
        
        if let currentSnapshot {
            dataSource?.apply(currentSnapshot)
        }
    }
    
}



