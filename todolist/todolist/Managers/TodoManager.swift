//
//  TodoManager.swift
//  todolist
//
//  Created by HumbertoPartida on 3/8/25.
//

import Foundation

protocol TodoDirecting {
    func listTodos(action: (Int, Todo?) -> Void)
    func addTodo(with title: String)
    func toggleCompletion(forTodoAtIndex index: Int)
    func deleteTodo(atIndex index: Int)
}


final class TodoManager {
    private let inMemoryCache = InMemoryCache()
    private let fileCache = JSONFileManagerCache()
}

extension TodoManager: TodoDirecting {
    func listTodos(action:(Int,Todo?) -> Void) {
        inMemoryCache.load()?.traverse(perform: action)
    }
    
    func addTodo(with title: String) {
        let todo = Todo(id: UUID(), title: title, isCompleted: false)
        inMemoryCache.save(todo: todo)
    }
    
    func toggleCompletion(forTodoAtIndex index: Int) {
        let node = inMemoryCache.load()?.nodeAt(index: index)
        guard let node else { return }
        node.value.isCompleted = !node.value.isCompleted
    }
    
    func deleteTodo(atIndex index: Int) {
        inMemoryCache.load()?.deleteNodeAt(index: index)
    }
    
}
