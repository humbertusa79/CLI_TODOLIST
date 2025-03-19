//
//  CacheManager.swift
//  todolist
//
//  Created by HumbertoPartida on 3/8/25.
//

import Foundation

protocol InLineCacheable {
    func save(todo: Todo)
    func load() -> LinkedList<Todo>?
}

protocol Persistable {
    func save(todos: LinkedList<Todo>?)
    func load() -> LinkedList<Todo>?
}

final class JSONFileManagerCache: Persistable {
    func save(todos: LinkedList<Todo>?) {
        
    }
    
    func load() -> LinkedList<Todo>? {
        return nil
    }
}

final class InMemoryCache: InLineCacheable {
    private var todoList: LinkedList<Todo> = LinkedList()
    func save(todo: Todo) {
        todoList.enqueue(value: todo)
    }
    
    func load() -> LinkedList<Todo>? {
        return todoList
    }
}
