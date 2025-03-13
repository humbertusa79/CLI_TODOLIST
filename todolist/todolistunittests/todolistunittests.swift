//
//  todolistunittests.swift
//  todolistunittests
//
//  Created by HumbertoPartida on 3/12/25.
//

import XCTest
@testable import todolist

final class todolistunittests: XCTestCase {
    func testTodoModelCreatedWithDefaultInitialValues() {
        let uid = UUID()
        let title = "task 1"
        let todo = makeTodo(id: uid,
                            title: title,
                            isCompleted: false)
        XCTAssertEqual(todo.id, uid)
        XCTAssertEqual(todo.title, title)
        XCTAssertFalse(todo.isCompleted)
    }
    
    func testIncompleteTodoDescription() {
        let uid = UUID()
        let title = "task 2"
        let todo = makeTodo(id: uid,
                            title: title,
                            isCompleted: false)
        XCTAssertEqual(todo.description, "[❌] \(title)")
    }
    
    func testCompletedTodoDescription(){
        let uid = UUID()
        let title = "task 3"
        let todo = makeTodo(id: uid,
                            title: title,
                            isCompleted: true)
        XCTAssertEqual(todo.description, "[✅] \(title)")
    }
    
    private func makeTodo(id: UUID,
                          title: String,
                          isCompleted: Bool) -> Todo {
        return Todo(id: id,
                    title: title,
                    isCompleted: isCompleted)
    }
}
