//
//  RPS.swift
//  LosingRockPaperScissors
//
//  Created by 김태호 on 2023/07/15.
//

import UIKit

enum Rps: CaseIterable {
    case rock
    case scissors
    case paper
    
    var info: (image: UIImage, name: String) {
        switch self {
        case .rock:
            return (#imageLiteral(resourceName: "Rock"), "바위")
        case .scissors:
            return (#imageLiteral(resourceName: "Scissors"), "가위")
        case .paper:
            return (#imageLiteral(resourceName: "Paper"), "보")
        }
    }
}
