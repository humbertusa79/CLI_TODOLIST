//
//  CacheManager.swift
//  todolist
//
//  Created by HumbertoPartida on 3/8/25.
//

import Foundation

protocol Cache {
    func save(todos: [Todo])
    func load() -> [Todo]?
}

final class JSONFileManagerCache: Cache {
    func save(todos: [Todo]) {
        
    }
    
    func load() -> [Todo]? {
        return nil
    }
}

final class InMemoryCache: Cache {
    func save(todos: [Todo]) {
        
    }
    
    func load() -> [Todo]? {
        return nil
    }
}
