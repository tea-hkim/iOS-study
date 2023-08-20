//
//  UITextField+.swift
//  ToDoApp
//
//  Created by 김태호 on 2023/04/12.
//

import Combine
import UIKit

extension UITextField {
    
    var textDidChangePublisher: AnyPublisher<UITextField, Never> {
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap { $0.object as? UITextField }
            .eraseToAnyPublisher()
    }
    
}
