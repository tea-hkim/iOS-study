//
//  UIImageView+.swift
//  YeogiEottaeClone
//
//  Created by Nick on 2023/07/24.
//

import UIKit
import WebKit
import SVGKit

// 출처 : https://www.hackingwithswift.com/example-code/uikit/how-to-load-a-remote-image-url-into-uiimageview

extension UIImageView {
    
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
     
    func loadSVG(url: URL) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let svgImage = SVGKImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = svgImage.uiImage
                    }
                }
            }
        }
    }
    
}
