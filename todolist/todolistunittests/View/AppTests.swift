//
//  AppTests.swift
//  todolistunittests
//
//  Created by HumbertoPartida on 3/12/25.
//

import XCTest
@testable import todolist

final class AppTests: XCTestCase {
    func testRunStateToggleExit() {
        let userInputStop: App.UserInputResult = { _ in
            "exit"
        }

        let app = App(readUserInput: userInputStop,
                      shouldStripString: false)
        app.run()
        XCTAssertEqual(app.currentState, .stop)
    }
}
