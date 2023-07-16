//
//  ViewController.swift
//  LosingRockPaperScissors
//
//  Created by 김태호 on 2023/07/14.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - Property
    
    private var timer: Timer?
    private var rpsNumber: Int = 0
    private var userPick: Rps? = nil
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var computerRPS: UIImageView!
    
    @IBOutlet weak var rockButton: UIImageView!
    @IBOutlet weak var paperButton: UIImageView!
    @IBOutlet weak var scissorsButton: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startGame()
        setAttribute()
        rpsButtonTapped()
    }
    
    // MARK: - Function
    
    private func setAttribute() {
        startButton.setTitleColor(.white, for: .normal)
    }
    
    private func changeCompueterRPS() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) {[weak self] _ in
            DispatchQueue.main.async {
                guard let self else { return }
                self.rpsNumber = (self.rpsNumber + 1) % 3
                self.computerRPS.image = Rps.allCases[self.rpsNumber % 3].info.image
            }
        }
    }
    
    private func startGame() {
        changeCompueterRPS()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.timer?.invalidate()
            self.timer = nil
            self.startButton.isHidden = false
        }
    }
    
    private func getResult() {
        
    }
    
    private func getReady() {
        titleLabel.text = "지는 가위바위보"
        startButton.setTitle("시작", for: .normal)
        resultLabel.isHidden = true
        resultLabel.text = ""
    }
    
    private func rpsButtonTapped() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        [rockButton, scissorsButton, paperButton].forEach {
            $0?.addGestureRecognizer(tapGestureRecognizer)
            $0?.isUserInteractionEnabled = true
        }
    }
    
    @objc
    private func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        tappedImage.alpha = 0.2
        print("tapped")
    }
    
    
    // MARK: - IBAction
    
    @IBAction func startButtoTapped(_ sender: UIButton) {
        startGame()
        startButton.isHidden = true
    }
    
    
}

