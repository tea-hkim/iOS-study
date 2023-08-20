//
//  Color+.swift
//  ToDoApp
//
//  Created by Nick on 2023/04/09.
//

import UIKit

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        return nil
    }
}

extension UIColor {
    static let grayF7F8FA = UIColor(hex: "#F7F8FAFF")
    static let gray73 = UIColor(hex: "#737373")
    static let grayF9 = UIColor(hex: "#F9F9F9F0")
    static let grayEB = UIColor(hex: "#EBEBEB")
    static let gray99 = UIColor(hex: "999999")
    static let gray3C43 = UIColor(hex: "#3C3C4399")
    static let whiteFB = UIColor(hex: "#FBFBFBFF")
    static let black17 = UIColor(hex: "#171717")
}
