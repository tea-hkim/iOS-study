//
//  GridViewController.swift
//  ModernCollectionView
//
//  Created by Nick on 2023/08/03.
//

import UIKit

final class GridViewController: UIViewController {

    // MARK: - Property
    
    private var collectionView: UICollectionView?
    private var dataSource: UICollectionViewDiffableDataSource<Section, Int>! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierachy()
        configureDataSource()
        makeSnapShot()
    }
    
}

// MARK: - Configure CollectionView

extension GridViewController {
    
    enum Section {
        case Grid
    }
    
    private func configureHierachy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView?.backgroundColor = .yellow
        view.addSubview(collectionView ?? UICollectionView())
    }
    
    // UICollectionViewLayout을 리턴하고 있는데 UICollectionViewCompositionalLayout을 리턴해도 됨
    private func createLayout() -> UICollectionViewLayout {
        let itemCount = 3
        let groupCount = 4
        let itemWitdthFraction: CGFloat = 1.0 / CGFloat(itemCount)
        let groupHeightFraction: CGFloat = 1.0 / CGFloat(groupCount)
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(itemWitdthFraction), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(groupHeightFraction))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: itemCount)
        group.interItemSpacing = .fixed(10)
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let section = NSCollectionLayoutSection(group: group)

        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<TextCell, Int> { (cell, indexPath, identifier) in
            // Populate the cell with our item description.
            cell.configureComponent(with: "\(identifier)")
        }
        
        guard let collectionView else { return }
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Int) -> UICollectionViewCell? in
            // Return the cell.
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
        }
    }
    
    private func makeSnapShot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.Grid])
        snapshot.appendItems(Array(0..<94))
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
}
