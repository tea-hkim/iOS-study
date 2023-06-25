//
//  ViewModel.swift
//  MovieApp
//
//  Created by 김태호 on 2023/06/21.
//

import Foundation
import RxSwift

class ViewModel {
    
    private let disposeBag = DisposeBag()
    private let tvNetwork: TVNetwork
    private let movieNetwork: MovieNetwork
    
    init() {
        let provider = NetworkProvider()
        self.tvNetwork = provider.makeTVNetwork()
        self.movieNetwork = provider.makeMovieNetwork()
    }
    
    struct Input {
        let tvTrigger: Observable<Void>
        let movieTrigger: Observable<Void>
    }
    
    struct Output {
        let tvList: Observable<[TV]?>
        let movieList: Observable<MovieSection?>
    }
    
    func transform(input: Input) -> Output {
        let tvListObservable = input.tvTrigger.flatMapLatest {[unowned self] _ -> Observable<[TV]?> in
            return self.tvNetwork.getTopRatedList().map { $0.tvList }
        }
        
        let movieListObservable = input.movieTrigger.flatMapLatest {[unowned self] _ -> Observable<MovieSection?> in
            return Observable.combineLatest(self.movieNetwork.getPopularList(), self.movieNetwork.getUpcomingList(), self.movieNetwork.getNowPlayingList()) { nowPlaying, popular, upComing -> MovieSection in
                return MovieSection(nowPlaying: nowPlaying, popular: popular, upComing: upComing)
            }
        }
        
        return Output(tvList: tvListObservable , movieList: movieListObservable)
    }
    
}


