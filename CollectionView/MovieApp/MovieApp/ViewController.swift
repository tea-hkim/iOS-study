//
//  ViewController.swift
//  MovieApp
//
//  Created by 김태호 on 2023/06/21.
//

import UIKit
import SnapKit
import RxSwift

class ViewController: UIViewController {
    
    // MARK: - UI Property
    
    private let tabButtonView = TabButtonView()
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    // MARK: - Property
    
    private let disposeBag = DisposeBag()
    private let viewModel = ViewModel()
    
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
    }
    
    // MARK: - UI Functions
    
    private func configureUI() {
        collectionView.backgroundColor = .blue
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
    
    // MARK: - Function
    
}

// MARK: - Bind

extension ViewController {
    
    private func bindViewModel() {
        let input = ViewModel.Input(tvTrigger: tvTrigger, movieTrigger: movieTrigger)
        let output = viewModel.transform(input: input)
        
        output.tvList.bind { tvList in
            guard let tvList else { return }
            print(tvList)
        }.disposed(by: disposeBag)
        
        output.movieList.bind { movieList in
            guard let movieList else { return }
            print(movieList)
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

