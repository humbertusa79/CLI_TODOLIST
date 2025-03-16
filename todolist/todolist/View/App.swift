//
//  App.swift
//  todolist
//
//  Created by HumbertoPartida on 3/8/25.
//

import Foundation

protocol MainLoop {
    func run()
}

final class App: MainLoop {
    typealias UserInputResult = (Bool) -> String?
    private var state: State
    var readUserInput: UserInputResult
    private let shouldStripString: Bool
    private var todoManager: TodoDirecting

    enum Commands: String {
        case add
        case list
        case delete
        case toggle
        case exit
    }
    
    enum State {
        case running
        case stop
    }
    
    init(readUserInput: @escaping UserInputResult,
         shouldStripString: Bool) {
        self.readUserInput = readUserInput
        self.shouldStripString = shouldStripString
        self.state = .running
        self.todoManager = TodoManager()
    }
    
    func run() {
        repeat {
            print("enter a command:", terminator: " ")
            let userInput = readUserInput(shouldStripString)
            if let userInput {
                let values = processInput(input: userInput)
                let command = Commands(rawValue: values.command)
                let value = values.value
                switch command {
                case .add:
                    todoManager.addTodo(with: value)
                case .list:
                    let todosList = todoManager.listTodos()
                    list(todos: todosList)
                case .delete:
                    if let index = Int(value) {
                        todoManager.deleteTodo(atIndex: index)
                    }
                case .toggle:
                    if let index = Int(value) {
                        todoManager.toggleCompletion(forTodoAtIndex: index)
                    }
                case .exit:
                    state = .stop
                default:
                    erroMessage()
                    
                }
            } else {
                erroMessage()
            }
        } while state == .running
    }

    private func erroMessage() {
        let errorMessage = """
        The options are: \n"
            -  📌 add [task name]
            -  📝 list
            -  🗑️ delete [task index]
            -  🌟 toggle [task index]
            - exit
        """
        print(errorMessage)
    }
    
    private func processInput(input: String) -> (command: String, value: String) {
        let split = input.split(separator: " ")
        let command = String(split.first ?? "")
        let value = String(split.last ?? "")
        return (command, value)
    }
    
    private func list(todos: LinkedList<Todo>?) {
        guard let todos = todos, !todos.isEmpty else {
            return
        }
        
        var iterator = todos.begin
        var counter = 1
        while iterator != nil {
            printTodo(withValue: iterator?.value.description ?? " ",
                      atIndex: counter)
            iterator = iterator?.next
            counter += 1
        }
    }

    private func printTodo(withValue value: String, atIndex index: Int) {
        print("\(index)  \(value)")
    }
}


#if DEBUG
extension App {
    var currentState: State {
        return state
    }
}
#endif
