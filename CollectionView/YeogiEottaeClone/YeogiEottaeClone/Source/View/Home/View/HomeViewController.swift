//
//  HomeViewController.swift
//  YeogiEottaeClone
//
//  Created by Nick on 2023/06/26.
//

import UIKit

enum CollectionViewSection: Hashable {
    case categoryDomestic
    case categoryOversea
    case bannerMarketing
    case couponEvent
    case hotelSale
    case poularPansion
    case city
    case ticketPlusHotel
}

enum CollectionViewItem: Hashable {
    case categroy(Component)
    case cityCategory
    case bannerImage
    case iconList
}

class HomeViewController: UIViewController {
    
    // MARK: - UI Property
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout()).then {
        $0.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.id)
    }
    private lazy var titleImage = UIImageView()
    
    // MARK: - Property
    
    private var viewModel: HomeViewModel?
    private var dataSource: UICollectionViewDiffableDataSource<CollectionViewSection, CollectionViewItem>?
    private var currentSnapshot: NSDiffableDataSourceSnapshot<CollectionViewSection, CollectionViewItem>?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDataSource()
        
        self.viewModel = HomeViewModel()
        viewModel?.onCompleted = {[weak self] in
            self?.setSnapshot()
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        viewModel?.dataTask()
        
        configureUI()
        configureHierachy()
    }
    
    // MARK: - UI Function
    
    private func configureUI() {
        view.backgroundColor = .white
    }
    
    private func configureHierachy() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Functions

    
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
    }
    
    private func setSnapshot() {
        let categorySection = CollectionViewSection.categoryDomestic
        
        currentSnapshot = NSDiffableDataSourceSnapshot<CollectionViewSection, CollectionViewItem>()
        currentSnapshot?.appendSections([categorySection])
        
        if let componentList = viewModel?.moduleList?[2].components {
            let catetgoryList = componentList.map { CollectionViewItem.categroy($0) }
            currentSnapshot?.appendItems(catetgoryList, toSection: categorySection)
        }
        if let currentSnapshot {
            dataSource?.apply(currentSnapshot)
        }
    }
    
}

// MARK: - Collectionview Section

extension HomeViewController {
    
    private func createCategorySection() -> NSCollectionLayoutSection {
        let itemCount: CGFloat = 4
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0/itemCount), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: Int(itemCount))
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
}



