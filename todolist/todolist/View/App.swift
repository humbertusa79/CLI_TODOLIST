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
                    list()
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
        let split = input.components(separatedBy: " ")
        let command = String(split.first ?? "")
        let value = String(split.dropFirst().joined(separator: " "))
        return (command, value)
    }
    
    private func list() {
        todoManager.listTodos { index, todo in
            print("\(index) \(todo?.description ?? "")")
        }
    }
}


#if DEBUG
extension App {
    var currentState: State {
        return state
    }
}
#endif
