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
    
    func run() {
        var state: State = .running
        while state == .running {
            let userInput = readUserInput()
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
    
    private func readUserInput() -> String? {
        var input = readLine()
        return input
    }
    
    private func erroMessage() {
        print("Please enter a command option: add, list, delete, toggle or exit")
    }
}
