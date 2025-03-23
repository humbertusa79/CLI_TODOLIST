//
//  main.swift
//  todolist
//
//  Created by HumbertoPartida on 3/8/25.
//

import Foundation

func readUserInput(strip: Bool) -> String? {
    let userinput = readLine()
    return userinput
}

func mainRun() {
    let app = App(readUserInput: readUserInput,
                  shouldStripString: false)
    app.run()
}

mainRun()
