//
//  ViewController.swift
//  BasicCompositionalLayout
//
//  Created by 김태호 on 2023/06/17.
//

import UIKit
import SnapKit

final class ViewController: UIViewController {
    
    // MARK: - UI Properties
    
    // TODO: - 레이아웃 추가
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    private var datasource: UICollectionViewDiffableDataSource<Section, Item>?
    
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCollecionView()
        setLayout()
    }
    

    
    // MARK: - Functions
    
    private func setLayout() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setCollecionView() {
        collectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: BannerCollectionViewCell.id)
        collectionView.setCollectionViewLayout(createLayout(), animated: true)
        
        setDataSource()
        setSnapShot()
    }
    
    
    // MARK: - CollectionView Layout
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout {[weak self] sectionIndex, _ in
            return self?.createBannerSection()
        }
    }
    
    private func createBannerSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
    // MARK: - CollectionView DataSource
    
    private func setDataSource() {
        datasource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            switch itemIdentifier {
            case let .banner(item):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.id,
                                                                    for: indexPath) as? BannerCollectionViewCell else  { return UICollectionViewCell() }
                cell.configComponents(title: item.title, imageUrl: item.imageUrl)
                return cell
            default: return UICollectionViewCell()
            }
        })
    }
    
    // MARK: - CollectionView SnapShot
    
    private func setSnapShot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        
        snapshot.appendSections([Section(id: "Banner")])
        let bannerItmeList = [
            Item.banner(HomeItem(title: "교촌", subTitle: nil, imageUrl: "https://image.homeplus.kr/td/f42afe4b-e0a8-4c79-a07c-aaee40c93a57")),
            Item.banner(HomeItem(title: "푸라닥", subTitle: nil, imageUrl: "https://image.homeplus.kr/td/f42afe4b-e0a8-4c79-a07c-aaee40c93a57")),
            Item.banner(HomeItem(title: "자담", subTitle: nil, imageUrl: "https://image.homeplus.kr/td/f42afe4b-e0a8-4c79-a07c-aaee40c93a57"))
        ]
        snapshot.appendItems(bannerItmeList)
        datasource?.apply(snapshot)
    }
    
}
