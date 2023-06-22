//
//  TVNetwork.swift
//  MovieApp
//
//  Created by 김태호 on 2023/06/21.
//

import Foundation
import RxSwift

final class TVNetwork {
    private let network: Network<TVListModel>
    
    init(network: Network<TVListModel>) {
        self.network = network
    }
    
    func getTopRatedList() -> Observable<TVListModel> {
        return network.getIemList(path: "/tv/top_rated")
    }
}
