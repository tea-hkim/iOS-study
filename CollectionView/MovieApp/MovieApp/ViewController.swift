//
//  ViewController.swift
//  MovieApp
//
//  Created by 김태호 on 2023/06/21.
//

import UIKit
import SnapKit
import RxSwift

enum Section: Hashable {
    case double
    case banner
    case horizontal(String)
    case vertical(String)
}

enum Item: Hashable {
    case normal(Content)
    case bigImage(Movie)
    case list(Movie)
}

class ViewController: UIViewController {
    
    // MARK: - UI Property
    
    private let tabButtonView = TabButtonView()
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout())
        collectionView.register(NormalCollectionViewCell.self, forCellWithReuseIdentifier: NormalCollectionViewCell.id)
        collectionView.register(BigImageCollectionViewCell.self, forCellWithReuseIdentifier: BigImageCollectionViewCell.id)
        collectionView.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: ListCollectionViewCell.id)
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.id)
        return collectionView
    }()

    
    // MARK: - Property
    
    private let disposeBag = DisposeBag()
    private let viewModel = ViewModel()
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    
    //output
    private let tvTrigger = PublishSubject<Void>()
    private let movieTrigger = PublishSubject<Void>()
    
    // MARK: - lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setConstraints()
        
        bindView()
        bindViewModel()
        
        tvTrigger.onNext(())
        setDataSource()
    }
    
    // MARK: - UI Functions
    
    private func setConstraints() {
        view.addSubview(tabButtonView)
        view.addSubview(collectionView)
        
        tabButtonView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(80)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(tabButtonView.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 14
        
        return UICollectionViewCompositionalLayout(sectionProvider: {[weak self] sectionIndex, _ in
            let section = self?.dataSource?.sectionIdentifier(for: sectionIndex)
            switch section {
            case .banner:
                return self?.createBannerScetion()
            case .double:
                return self?.createDoubleSection()
            case .horizontal:
                return self?.createHorizontalSection()
            case .vertical:
                return self?.createListSection()
            default:
                return self?.createDoubleSection()
            }
        }, configuration: config)
    }
    
    private func createDoubleSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(320))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    private func createBannerScetion() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(640))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
    private func createHorizontalSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .estimated(240))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    private func createListSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.3))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(320))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, repeatingSubitem: item, count: 3)
        group.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    private func setDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            switch item {
            case .normal(let contentData):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NormalCollectionViewCell.id, for: indexPath) as? NormalCollectionViewCell
                cell?.configureComponents(imageUrl: contentData.posterURL, title: contentData.name, review: contentData.vote, description: contentData.overview)
                return cell
            case .bigImage(let movieData):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BigImageCollectionViewCell.id, for: indexPath) as? BigImageCollectionViewCell
                cell?.configureComponents(imageUrl: movieData.posterURL , title: movieData.name, review: movieData.vote, description: movieData.overview)
                return cell
            case .list(let movieData):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.id, for: indexPath) as? ListCollectionViewCell
                cell?.configureComponents(imageUrl: movieData.posterURL, title: movieData.name, releaseDate: movieData.releaseDate)
                return cell
            }
        })
        
        dataSource?.supplementaryViewProvider = {[weak self] collectionView, kind, indexPath -> UICollectionReusableView in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.id, for: indexPath)
            let section = self?.dataSource?.sectionIdentifier(for: indexPath.section)
            
            switch section {
            case .horizontal(let title):
                (header as? HeaderView)?.configureComponent(title: title)
            case .vertical(let title):
                (header as? HeaderView)?.configureComponent(title: title)
            default: break
            }
            
            
            return header
        }
    }
    
}

// MARK: - Bind

extension ViewController {
    
    private func bindViewModel() {
        let input = ViewModel.Input(tvTrigger: tvTrigger, movieTrigger: movieTrigger)
        let output = viewModel.transform(input: input)
        
        output.tvList.bind { tvList in
            guard let tvList else { return }
            var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
            let itemList = tvList.map { Item.normal(Content(tv: $0)) }
            let section = Section.double
            snapshot.appendSections([section])
            snapshot.appendItems(itemList, toSection: section)
            self.dataSource?.apply(snapshot)
        }.disposed(by: disposeBag)
        
        output.movieList.bind { movieList in
            guard let movieList else { return }
            var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
            
            let bigImageitemList = movieList.nowPlaying.movieList?.map { Item.bigImage($0) }
            let bannerSection = Section.banner
            snapshot.appendSections([bannerSection])
            snapshot.appendItems(bigImageitemList ?? [], toSection: bannerSection)
            
            let horizontalSection = Section.horizontal("Popular Movies")
            let normalList = movieList.popular.movieList?.map { Item.normal(Content(movie: $0)) }
            snapshot.appendSections([horizontalSection])
            snapshot.appendItems(normalList ?? [], toSection: horizontalSection)
            
            let upComingSection = Section.vertical("Up Coming Movies")
            let upComingList = movieList.upComing.movieList?.map { Item.list($0) }
            snapshot.appendSections([upComingSection])
            snapshot.appendItems(upComingList ?? [], toSection: upComingSection)
            
            self.dataSource?.apply(snapshot)
        }.disposed(by: disposeBag)
    }
    
    private func bindView() {
        tabButtonView.tvButton.rx.tap.bind {[weak self] in
            self?.tvTrigger.onNext(Void())
        }.disposed(by: disposeBag)
        
        tabButtonView.movieButton.rx.tap.bind {[weak self] in
            self?.movieTrigger.onNext(Void())
        }.disposed(by: disposeBag)
    }
    
}

