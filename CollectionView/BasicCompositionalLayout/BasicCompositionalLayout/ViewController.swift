//
//  ViewController.swift
//  BasicCompositionalLayout
//
//  Created by 김태호 on 2023/06/17.
//

import UIKit
import SnapKit

final class ViewController: UIViewController {
    
    // MARK: - Properties
    
    // TODO: - 레이아웃 추가
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    private var datasource: UICollectionViewDiffableDataSource<Section, Item>?
    
    private let imageUrl = "https://image.homeplus.kr/td/f42afe4b-e0a8-4c79-a07c-aaee40c93a57"
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCollecionView()
        setConstraints()
    }
    

    
    // MARK: - Functions
    
    private func setConstraints() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setCollecionView() {
        collectionView.register(BannerCollectionViewCell.self,
                                forCellWithReuseIdentifier: BannerCollectionViewCell.id)
        collectionView.register(NormalCarouselCollectionViewCell.self,
                                forCellWithReuseIdentifier: NormalCarouselCollectionViewCell.id)
        collectionView.register(ListCarouselCollectionViewCell.self,
                                forCellWithReuseIdentifier: ListCarouselCollectionViewCell.id)
        
        collectionView.setCollectionViewLayout(createLayout(), animated: true)
        collectionView.backgroundColor = .yellow
        
        setDataSource()
        setSnapShot()
    }
    
    
    // MARK: - CollectionView Layout
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let layoutConfig = UICollectionViewCompositionalLayoutConfiguration()
        layoutConfig.interSectionSpacing = 30
        
        return UICollectionViewCompositionalLayout (sectionProvider: {[weak self] sectionIndex, _ in
            switch sectionIndex {
            case 0:
                return self?.createBannerSection()
            case 1:
                return self?.createNormalCarouselSection()
            case 2:
                return self?.createListCarouselSection()
            default:
                return self?.createBannerSection()
            }
        }, configuration: layoutConfig)
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
    
    private func createNormalCarouselSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7),
                                               heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    private func createListCarouselSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(0.33))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(250))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, repeatingSubitem: item, count: 3)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 40, leading: 20, bottom: 0, trailing: 20)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    // MARK: - CollectionView DataSource
    
    private func setDataSource() {
        datasource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            switch itemIdentifier {
            case let .banner(item):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.id, for: indexPath) as? BannerCollectionViewCell else  { return UICollectionViewCell() }
                cell.configComponents(title: item.title, imageUrl: item.imageUrl)
                return cell
            case let .normalCarousel(item):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NormalCarouselCollectionViewCell.id, for: indexPath) as? NormalCarouselCollectionViewCell else  { return UICollectionViewCell() }
                cell.configComponents(imageUrl: item.imageUrl, title: item.title,  subtitle: item.subTitle)
                return cell
            case let .listCarousel(item):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCarouselCollectionViewCell.id, for: indexPath) as? ListCarouselCollectionViewCell else  { return UICollectionViewCell() }
                cell.configComponents(imageUrl: item.imageUrl, title: item.title,  subtitle: item.subTitle)
                return cell
            }
        })
    }
    
    // MARK: - CollectionView SnapShot
    
    private func setSnapShot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        
        let bannerSection = Section(id: "Banner")
        snapshot.appendSections([bannerSection])
        let bannerItemList = [
            Item.banner(HomeItem(title: "교촌", subTitle: nil, imageUrl: "https://image.homeplus.kr/td/f42afe4b-e0a8-4c79-a07c-aaee40c93a57")),
            Item.banner(HomeItem(title: "굽네", subTitle: nil, imageUrl: "https://image.homeplus.kr/td/f42afe4b-e0a8-4c79-a07c-aaee40c93a57")),
            Item.banner(HomeItem(title: "자담", subTitle: nil, imageUrl: "https://image.homeplus.kr/td/f42afe4b-e0a8-4c79-a07c-aaee40c93a57"))
        ]
        snapshot.appendItems(bannerItemList, toSection: bannerSection)
        
        let normalSection = Section(id: "NormalCarousel")
        snapshot.appendSections([normalSection])
        let normalCarouselItem = [
            Item.normalCarousel(HomeItem(title: "교촌 치킨", subTitle: "허니 콤보", imageUrl: imageUrl)),
            Item.normalCarousel(HomeItem(title: "굽네 치킨", subTitle: "오븐치킨", imageUrl: imageUrl)),
            Item.normalCarousel(HomeItem(title: "자담 치킨", subTitle: "맵슐랭", imageUrl: imageUrl)),
            Item.normalCarousel(HomeItem(title: "처갓집", subTitle: "슈프림", imageUrl: imageUrl)),
            Item.normalCarousel(HomeItem(title: "페리카나", subTitle: "반반치킨", imageUrl: imageUrl)),
        ]
        snapshot.appendItems(normalCarouselItem, toSection: normalSection)
        
        let listSection = Section(id: "ListCarousel")
        snapshot.appendSections([listSection])
        let listCarouselItem = [
            Item.listCarousel(HomeItem(title: "교촌 치킨", subTitle: "허니 콤보", imageUrl: imageUrl)),
            Item.listCarousel(HomeItem(title: "굽네 치킨", subTitle: "오븐치킨", imageUrl: imageUrl)),
            Item.listCarousel(HomeItem(title: "자담 치킨", subTitle: "맵슐랭", imageUrl: imageUrl)),
            Item.listCarousel(HomeItem(title: "처갓집", subTitle: "슈프림", imageUrl: imageUrl)),
            Item.listCarousel(HomeItem(title: "페리카나", subTitle: "반반치킨", imageUrl: imageUrl)),
        ]
        snapshot.appendItems(listCarouselItem, toSection: listSection)
        
        datasource?.apply(snapshot)
    }
    
}
