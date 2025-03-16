//
//  TodoManager.swift
//  todolist
//
//  Created by HumbertoPartida on 3/8/25.
//

import Foundation

protocol TodoDirecting {
    func listTodos() -> [Todo]?
    func addTodo(with title: String)
    func toggleCompletion(forTodoAtIndex index: Int)
    func deleteTodo(atIndex index: Int)
}


final class TodoManager {
    
}
