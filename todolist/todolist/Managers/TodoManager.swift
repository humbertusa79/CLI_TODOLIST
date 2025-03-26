//
//  TodoManager.swift
//  todolist
//
//  Created by HumbertoPartida on 3/8/25.
//

import Foundation

enum Commands: String {
    case add
    case list
    case delete
    case toggle
    case exit
    case help
}

enum CommandError: Error {
    case addEmptyString
    case notSupported
    case deleteIndexOutOfBounds
    case deleteIndexNaN
    case toggleIndexOutOfBounds
    case toggleIndexNaN
    case emptyList
}

protocol TodoDirecting {
    func listTodos(action: (Int, Todo?) -> Void)
    func addTodo(with title: String) -> Bool
    func toggleCompletion(forTodoAtIndex index: Int)
    func deleteTodo(atIndex index: Int)
    func saveTodos() -> Bool
    func loadTodos()
    func processCommand(command: Commands?, value: String) throws
    var count: Int { get }
}


final class TodoManager {
    private let inMemoryCache = InMemoryCache()
    private let fileCache = JSONFileManagerCache()
}

extension TodoManager: TodoDirecting {
    var count: Int {
        inMemoryCache.count
    }
    
    func listTodos(action:(Int,Todo?) -> Void) {
        inMemoryCache.load()?.traverse(perform: action)
    }
    
    func addTodo(with title: String) -> Bool {
        let todo = Todo(id: UUID(), title: title, isCompleted: false)
        return inMemoryCache.save(todo: todo)
    }
    
    func toggleCompletion(forTodoAtIndex index: Int) {
        let node = inMemoryCache.load()?.nodeAt(index: index)
        guard let node else { return }
        node.value.isCompleted = !node.value.isCompleted
    }
    
    func deleteTodo(atIndex index: Int) {
        inMemoryCache.load()?.deleteNodeAt(index: index)
    }
    
    func saveTodos() -> Bool {
        guard let todos = inMemoryCache.load() else { return  false }
        return fileCache.save(todos: todos)
    }
    
    func loadTodos() {
        guard let todos = fileCache.load() else { return }
        inMemoryCache.load(todos: todos)
    }
    
}

extension TodoManager {
    func processCommand(command: Commands?, value: String) throws {
        guard let command else { throw CommandError.notSupported }
        switch command {
        case .add:
            guard !value.isEmpty else { throw CommandError.addEmptyString }
            return
        
        case .delete:
            guard self.count > 0 else { throw CommandError.emptyList }
            try isValid(value: value, with: [.deleteIndexNaN, .deleteIndexOutOfBounds])
            return
            
        case .toggle:
            guard self.count > 0 else { throw CommandError.emptyList }
            try isValid(value: value, with: [.toggleIndexNaN, .toggleIndexOutOfBounds])
            return
            
        case .list:
            guard self.count > 0 else { throw CommandError.emptyList }
        case .exit, .help:
            break
        }
    }
    
    private func isValid(value: String,
                         with errors: [CommandError]) throws {
        let index = Int(value)
        guard let index else { throw errors[0]  }
        guard index > 0 && index <= self.count else { throw errors[1] }
        return
    }

}

#if DEBUG
extension TodoManager {
    var testHandler: DebugHandler {
        return DebugHandler(target: self)
    }

    struct DebugHandler {
        let target: TodoManager
        
        fileprivate init(target: TodoManager) {
            self.target = target
        }
        
        var todoList: LinkedList<Todo> {
            target.inMemoryCache.testHandler.todoList
        }
    }
}
#endif
