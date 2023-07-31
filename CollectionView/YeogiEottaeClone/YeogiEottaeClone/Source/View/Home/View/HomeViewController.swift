//
//  HomeViewController.swift
//  YeogiEottaeClone
//
//  Created by Nick on 2023/06/26.
//

import UIKit
import SwiftUI

enum CollectionViewSection: Hashable {
    case categoryDomestic(String)
    case categoryOversea(String)
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
        $0.register(CategoryHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CategoryHeaderView.id)
    }
    private lazy var titleImage = UIImageView()
    
    // MARK: - Property
    
    private var viewModel: HomeViewModel?
    private var dataSource: UICollectionViewDiffableDataSource<CollectionViewSection, CollectionViewItem>?
    private var currentSnapshot: NSDiffableDataSourceSnapshot<CollectionViewSection, CollectionViewItem>?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
        configureDataSource()
    }
    
    // MARK: - UI Function
    
    private func configureUI() {
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
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
        return UICollectionViewCompositionalLayout {[weak self] sectionIndex, _ in
            let section = self?.dataSource?.sectionIdentifier(for: sectionIndex)
            switch section {
            case .categoryDomestic:
                return self?.createCategorySection(isOverSea: false)
            case .categoryOversea:
                return self?.createCategorySection(isOverSea: true)
            default:
                return self?.createCategorySection(isOverSea: true)
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
        
        dataSource?.supplementaryViewProvider = {[weak self] collectionView, kind, indexPath -> UICollectionReusableView in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CategoryHeaderView.id, for: indexPath)
            let section = self?.dataSource?.sectionIdentifier(for: indexPath.section)
            
            switch section {
            case .categoryDomestic(let headerImageUrlString):
                (header as? CategoryHeaderView)?.configureComponent(imageUrlString: headerImageUrlString)
            case .categoryOversea(let headerImageUrlString):
                (header as? CategoryHeaderView)?.configureComponent(imageUrlString: headerImageUrlString)
            default: break
            }
            
            return header
        }
    }
    
    private func setSnapshot() {
        guard let modules = viewModel?.moduleList else { return }
        
        currentSnapshot = NSDiffableDataSourceSnapshot<CollectionViewSection, CollectionViewItem>()
        
        guard let headerImageUrlString = modules[1].components?.first?.image?.contents.first?.value else { return }
        let categoryDomesticSection = CollectionViewSection.categoryDomestic(headerImageUrlString)
        currentSnapshot?.appendSections([categoryDomesticSection])
        if let componentList = modules[2].components {
            let catetgoryList = componentList.map { CollectionViewItem.categroy($0) }
            currentSnapshot?.appendItems(catetgoryList, toSection: categoryDomesticSection)
        }
        
        guard let overseaHeaderImageUrlString = modules[3].components?.first?.image?.contents.first?.value else { return }
        let categoryOverseaSection = CollectionViewSection.categoryOversea(overseaHeaderImageUrlString)
        currentSnapshot?.appendSections([categoryOverseaSection])
        if let componentList = modules[4].components {
            let catetgoryList = componentList.map { CollectionViewItem.categroy($0) }
            currentSnapshot?.appendItems(catetgoryList, toSection: categoryOverseaSection)
        }
        
        if let currentSnapshot {
            dataSource?.apply(currentSnapshot)
        }
    }
    
}

// MARK: - Collectionview Section

extension HomeViewController {
    
    private func createCategorySection(isOverSea: Bool) -> NSCollectionLayoutSection {
        let itemCount: CGFloat = 4
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0/itemCount), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: Int(itemCount))
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 15
        section.contentInsets = NSDirectionalEdgeInsets(top: isOverSea ? 0 : 20, leading: 0, bottom: isOverSea ? 0 : 10, trailing: 0)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(isOverSea ? 0.05 : 0.1))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
}

// MARK: - Preview

struct HomeViewControllerPreView:PreviewProvider {
    static var previews: some View {
        HomeViewController().toPreview()
    }
}


