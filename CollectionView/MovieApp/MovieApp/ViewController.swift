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
}
enum Item: Hashable {
    case normal(TV)
}

class ViewController: UIViewController {
    
    // MARK: - UI Property
    
    private let tabButtonView = TabButtonView()
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout())
        collectionView.register(NormalCollectionViewCell.self, forCellWithReuseIdentifier: NormalCollectionViewCell.id)
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
        
        configureUI()
        setConstraints()
        
        bindView()
        bindViewModel()
        
        tvTrigger.onNext(())
        setDataSource()
    }
    
    // MARK: - UI Functions
    
    private func configureUI() {
    }
    
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
            return self?.createDoubleSection()
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
    
    private func setDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            switch item {
            case .normal(let tvData):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NormalCollectionViewCell.id, for: indexPath) as? NormalCollectionViewCell
                cell?.configureComponents(imageUrl: tvData.posterURL, title: tvData.name, review: tvData.vote, description: tvData.overview)
                return cell
            }
        })
    }
    
    // MARK: - Function
    
}

// MARK: - Bind

extension ViewController {
    
    private func bindViewModel() {
        let input = ViewModel.Input(tvTrigger: tvTrigger, movieTrigger: movieTrigger)
        let output = viewModel.transform(input: input)
        
        output.tvList.bind { tvList in
            guard let tvList else { return }
            var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
            let itemList = tvList.map { Item.normal($0) }
            let section = Section.double
            snapshot.appendSections([section])
            snapshot.appendItems(itemList, toSection: section)
            self.dataSource?.apply(snapshot)
        }.disposed(by: disposeBag)
        
        output.movieList.bind { movieList in
            guard let movieList else { return }
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

