//
//  Date+.swift
//  BasicTodoList
//
//  Created by 김태호 on 11/26/23.
//

import Foundation

extension Date {
    
    public func toString() -> String {
        let format = "yy-mm-dd"
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: self)
    }
    
}
