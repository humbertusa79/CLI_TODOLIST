//
//  todolistunittests.swift
//  todolistunittests
//
//  Created by HumbertoPartida on 3/12/25.
//

import XCTest
@testable import todolist

final class TodoUnitTests: XCTestCase {
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
    
    func testTodoManagerAddTodo() {
        let todoManager = TodoManager()
        XCTAssertEqual(todoManager.testHandler.todoList.count, 0)
        let isSaved = todoManager.addTodo(with: "Task 1")
        XCTAssertTrue(isSaved)
        XCTAssertEqual(todoManager.count, 1)
    }
    
    func testTodoManagerDeleteTodo() {
        let todoManager = TodoManager()
        XCTAssertEqual(todoManager.testHandler.todoList.count, 0)
        let _ = todoManager.addTodo(with: "Task1")
        XCTAssertEqual(todoManager.count, 1)
        todoManager.deleteTodo(atIndex: 1)
        XCTAssertEqual(todoManager.count, 0)
    }
    
    func testTodoManagerToggleTodo() {
        let todoManager = TodoManager()
        let _ = todoManager.addTodo(with: "Task1")
        let todo = todoManager.testHandler.todoList.nodeAt(index: 1)
        guard let notCompleted = try? !XCTUnwrap(todo?.value.isCompleted) else {
            XCTFail("could not find the to do task in the list")
            return
        }
        
        XCTAssertTrue(notCompleted)
        todoManager.toggleCompletion(forTodoAtIndex: 1)
        guard let completed = try? XCTUnwrap(todo?.value.isCompleted) else {
            XCTFail("could not find the to do task in the list")
            return
        }

        XCTAssertTrue(completed)
        
    }
    
}

extension TodoUnitTests {
    func makeTodo(id: UUID,
                  title: String,
                  isCompleted: Bool) -> Todo {
        return Todo(id: id,
                    title: title,
                    isCompleted: isCompleted)
    }
}
