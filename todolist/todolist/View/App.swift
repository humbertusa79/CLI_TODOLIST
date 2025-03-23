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
}

extension App {
    func run() {
        todoManager.loadTodos()
        repeat {
            print("enter a command:", terminator: " ")
            let userInput = readUserInput(shouldStripString)
            if let userInput {
                let values = processInput(input: userInput)
                let command = Commands(rawValue: values.command)
                let value = values.value
                do {
                    try todoManager.processCommand(command: command,
                                                   value: value)
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
                        todoManager.saveTodos()
                        state = .stop
                    default:
                        optionErroMessage()
                    }
                } catch (let error) {
                    if let error = error as? CommandError {
                        displayMessage(for: error)
                    } else {
                        optionErroMessage()
                    }
                }
            } else {
                optionErroMessage()
            }
        } while state == .running
    }
}


extension App {
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

extension App {
    private func optionErroMessage() {
        let errorMessage = """
        The options are: \n"
            -  📌) add [task name]
            -  📝) list
            -  🗑️) delete [task index]
            -  🌟) toggle [task index]
            -  ⛔) exit
        """
        print(errorMessage)
    }
    
    private func displayMessage(for error: CommandError) {
        switch error {
        case .notSupported:
            print("The command entered is not supported, please use")
            optionErroMessage()
            
        case .addEmptyString:
            print("The add command receives a non empty string")
        
        case .deleteIndexNaN:
            print("The delete command receives an integer index")
        
        case .deleteIndexOutOfBounds:
            print("The delete command receives an integer index between 1 and the total number of todos")
            
        case .toggleIndexNaN:
            print("The toggle command receives an integer index")
            
        case .toggleIndexOutOfBounds:
            print("The toggle command receives an integer index between 1 and the total number of todos")
            
        case .emptyList:
            print("The to do list is empty, add some tasks using the command 📌: add [task name]")
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
