//
//  TodoManager.swift
//  todolist
//
//  Created by HumbertoPartida on 3/8/25.
//

import Foundation

protocol TodoDirecting {
    func listTodos() -> LinkedList<Todo>?
    func addTodo(with title: String)
    func toggleCompletion(forTodoAtIndex index: Int)
    func deleteTodo(atIndex index: Int)
}


final class TodoManager {
    private var todoList: LinkedList<Todo> = LinkedList()
}

extension TodoManager: TodoDirecting {
    func listTodos() -> LinkedList<Todo>? {
        return todoList
    }
    
    func addTodo(with title: String) {
        let todo = Todo(id: UUID(), title: title, isCompleted: false)
        todoList.push(value: todo)
    }
    
    func toggleCompletion(forTodoAtIndex index: Int) {
        let node = todoList.nodeAt(index: index)
        guard let node = node.current else { return }
        node.value.isCompleted = !node.value.isCompleted
    }
    
    func deleteTodo(atIndex index: Int) {
        todoList.deleteNodeAt(index: index)
    }
    
}
