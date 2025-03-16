//
//  Todo.swift
//  todolist
//
//  Created by HumbertoPartida on 3/8/25.
//

import Foundation

struct Todo: Codable {
    let id: UUID
    private(set) var title: String
    var isCompleted: Bool
}

extension Todo: CustomStringConvertible {
    var description: String {
        return "[\(icon)] \(title)"
    }

    private var icon: String {
        return isCompleted ? "✅" : "❌"
    }
}
