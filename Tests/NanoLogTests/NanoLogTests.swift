// Copyright (C) 2018 Andrew Lord
//
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with
// the License.
//
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//
// See the License for the specific language governing permissions and limitations under the License.

import Nimble
import XCTest

@testable import NanoLog

class NanoLogTests: XCTestCase {

    private let controller = LogControllerFake()
    private var previousController: LogController!

    override func setUp() {
        super.setUp()

        previousController = NanoLog.controller
        NanoLog.controller = controller
    }

    override func tearDown() {
        super.tearDown()

        NanoLog.controller = previousController
    }
}

// MARK: - Tests
extension NanoLogTests {
    func test_whenMessage_thenMessageLoggedToController() {
        let expectedMessage = "Some message"
        let expectedSeverity = LogSeverity.warning

        NanoLog.message(expectedMessage, withSeverity: expectedSeverity)

        expect(self.controller.loggedMessage).to(equal(expectedMessage))
        expect(self.controller.loggedSeverity?.severity).to(equal(expectedSeverity.severity))
    }
}

extension NanoLogTests {
    static var allTests = [
        ("test_whenMessage_thenMessageLoggedToController", test_whenMessage_thenMessageLoggedToController),
    ]
}
