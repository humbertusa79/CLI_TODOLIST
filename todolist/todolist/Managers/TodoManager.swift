//
//  TodoManager.swift
//  todolist
//
//  Created by HumbertoPartida on 3/8/25.
//

import Foundation

protocol TodoDirecting {
    func getTodos() -> [Todo]?
    func add(todo: Todo)
    func toggleCompletion(forTodoAtIndex index: Int)
    func remove(todoAtIndex index: Int)
}


final class TodoManager {
    
}
