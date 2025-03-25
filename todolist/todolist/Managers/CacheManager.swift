//
//  CacheManager.swift
//  todolist
//
//  Created by HumbertoPartida on 3/8/25.
//

import Foundation

enum CacheError {
    case unableToSaveData
}

protocol InLineCacheable {
    func save(todo: Todo) -> Bool
    func load() -> LinkedList<Todo>?
}

protocol Persistable {
    func save(todos: LinkedList<Todo>) -> Bool
    func load() -> LinkedList<Todo>?
}

final class JSONFileManagerCache: Persistable {
    func save(todos: LinkedList<Todo>) -> Bool {
        let encoder = JSONEncoder()
        do {
            var todosArray: [Todo] = []
            todos.traverse { index, todo in
                guard let todo else { return }
                todosArray.append(todo)
            }
            let data = try encoder.encode(todosArray)
            let fileManager = FileManager.default
            let url = fileManager.homeDirectoryForCurrentUser.appending(component: "todolist")
            try data.write(to: url)
            return true
        } catch (let error) {
            print("there was an error encoding the data \(error)")
            return false
        }
    }
    
    func load() -> LinkedList<Todo>? {
        let fileManager = FileManager.default
        let url = fileManager.homeDirectoryForCurrentUser.appending(component: "todolist")
        do {
            let data = try Data(contentsOf: url)
            let todos = try JSONDecoder().decode([Todo].self, from: data)
            let linkedList = LinkedList<Todo>()
            for todo in todos {
                linkedList.enqueue(value: todo)
            }
            return linkedList
        }catch( _) {
            return nil
        }
    }
}

final class InMemoryCache: InLineCacheable {
    private var todoList: LinkedList<Todo> = LinkedList()
    var count: Int {
        todoList.count
    }

    func save(todo: Todo) -> Bool {
        let count = todoList.count
        todoList.enqueue(value: todo)
        return count < todoList.count
    }
    
    func load() -> LinkedList<Todo>? {
        return todoList
    }

    func load(todos: LinkedList<Todo>) {
        self.todoList = todos
    }
}
