//
//  TodoList.swift
//  BasicTodoList
//
//  Created by 김태호 on 11/26/23.
//

import Foundation

final class TodoList {
    
    static let empty: [Todo] = [
        Todo(title: "일본어 회화", creationDate: Date(), isDone: false),
        Todo(title: "영어 회화", creationDate: Date(), isDone: false),
        Todo(title: "장보기", creationDate: Date(), isDone: true),
        Todo(title: "경제 기사 요약", creationDate: Date(), isDone: false),
        Todo(title: "타자연습", creationDate: Date(), isDone: true),
    ]
    
}
