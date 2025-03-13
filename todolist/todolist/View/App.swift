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
    }
    
    func run() {
        while state == .running {
            let userInput = readUserInput(shouldStripString)
            if let userInput {
                let command = Commands(rawValue: userInput)
                switch command {
                case .add:
                    break
                case .list:
                    break
                case .delete:
                    break
                case .toggle:
                    break
                case .exit:
                    state = .stop
                default:
                    erroMessage()
                    
                }
            } else {
                erroMessage()
            }
        }
    }

    private func erroMessage() {
        let errorMessage = """
        Please enter a command option: \n"
            add [task name]
            list
            delete [task name]
            toggle [task index]
            exit
        """
        print(errorMessage)
    }
}


#if DEBUG
extension App {
    var currentState: State {
        return state
    }
}
#endif
