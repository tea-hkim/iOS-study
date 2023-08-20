//
//  UIView+.swift
//  ToDoApp
//
//  Created by Nick on 2023/04/09.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: [UIView]) {
        for view in views {
            self.addSubview(view)
        }
    }
    
}
