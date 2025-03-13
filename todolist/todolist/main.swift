//
//  main.swift
//  todolist
//
//  Created by HumbertoPartida on 3/8/25.
//

import Foundation

// Main entry point

let app = App(readUserInput: readUserInput,
              shouldStripString: false)
app.run()

func readUserInput(strip: Bool) -> String? {
    let userinput = readLine()
    return userinput
}
