//
//  LoginVCTests.swift
//  KataLoginOutTests
//
//  Created by Miguel Hernández Jaso on 24/01/2019.
//  Copyright © 2019 Miguel Hernández Jaso. All rights reserved.
//

import XCTest
@testable import KataLoginOut

class LoginVCTests: XCTestCase {
    typealias sut = Login

    func testLogsWithAdminAdmin() {
        let loginResult = sut.login(withUser: "admin", password: "admin")
        XCTAssertEqual(loginResult, Result.success)
    }

    func testLogsWithAdminEmpty() {
        let loginResult = sut.login(withUser: "admin", password: "")
        XCTAssertEqual(loginResult, Result.failure)
    }

    func testLogsWithEmptyAdmin() {
        let loginResult = sut.login(withUser: "", password: "admin")
        XCTAssertEqual(loginResult, Result.failure)
    }

    func testLogsWithEmptyEmpty() {
        let loginResult = sut.login(withUser: "", password: "")
        XCTAssertEqual(loginResult, Result.failure)
    }
}

class LogoutVCTests: XCTestCase {
    typealias sut = Logout

    func testLogsWithEvenDate() {
        let timeProvider = MockTimeProvider(currentTimeInSeconds: 2)
        let result = sut.logout(withTimeProvider: timeProvider)
        XCTAssertEqual(result, Result.success)
    }

    func testLogsWithOddDate() {
        let timeProvider = MockTimeProvider(currentTimeInSeconds: 1)
        let result = sut.logout(withTimeProvider: timeProvider)
        XCTAssertEqual(result, Result.failure)
    }
}
