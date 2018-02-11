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
    func test_whenV_thenVerboseMessageLoggedToController() {
        let expectedMessage = "Some message"
        let expectedSeverity = LogSeverity.verbose

        NanoLog.v(expectedMessage)

        expect(self.controller.loggedMessage).to(equal(expectedMessage))
        expect(self.controller.loggedSeverity?.severity).to(equal(expectedSeverity.severity))
    }

    func test_whenVerbose_thenVerboseMessageLoggedToController() {
        let expectedMessage = "Some message"
        let expectedSeverity = LogSeverity.verbose

        NanoLog.verbose(expectedMessage)

        expect(self.controller.loggedMessage).to(equal(expectedMessage))
        expect(self.controller.loggedSeverity?.severity).to(equal(expectedSeverity.severity))
    }

    func test_whenD_thenDebugMessageLoggedToController() {
        let expectedMessage = "Some message"
        let expectedSeverity = LogSeverity.debug

        NanoLog.d(expectedMessage)

        expect(self.controller.loggedMessage).to(equal(expectedMessage))
        expect(self.controller.loggedSeverity?.severity).to(equal(expectedSeverity.severity))
    }

    func test_whenDebug_thenDebugMessageLoggedToController() {
        let expectedMessage = "Some message"
        let expectedSeverity = LogSeverity.debug

        NanoLog.debug(expectedMessage)

        expect(self.controller.loggedMessage).to(equal(expectedMessage))
        expect(self.controller.loggedSeverity?.severity).to(equal(expectedSeverity.severity))
    }

    func test_whenI_thenInfoMessageLoggedToController() {
        let expectedMessage = "Some message"
        let expectedSeverity = LogSeverity.info

        NanoLog.i(expectedMessage)

        expect(self.controller.loggedMessage).to(equal(expectedMessage))
        expect(self.controller.loggedSeverity?.severity).to(equal(expectedSeverity.severity))
    }

    func test_whenInfo_thenInfoMessageLoggedToController() {
        let expectedMessage = "Some message"
        let expectedSeverity = LogSeverity.info

        NanoLog.info(expectedMessage)

        expect(self.controller.loggedMessage).to(equal(expectedMessage))
        expect(self.controller.loggedSeverity?.severity).to(equal(expectedSeverity.severity))
    }

    func test_whenW_thenWarningMessageLoggedToController() {
        let expectedMessage = "Some message"
        let expectedSeverity = LogSeverity.warning

        NanoLog.w(expectedMessage)

        expect(self.controller.loggedMessage).to(equal(expectedMessage))
        expect(self.controller.loggedSeverity?.severity).to(equal(expectedSeverity.severity))
    }

    func test_whenWarning_thenWarningMessagedLoggedToController() {
        let expectedMessage = "Some message"
        let expectedSeverity = LogSeverity.warning

        NanoLog.warning(expectedMessage)

        expect(self.controller.loggedMessage).to(equal(expectedMessage))
        expect(self.controller.loggedSeverity?.severity).to(equal(expectedSeverity.severity))
    }

    func test_whenE_thenErrorMessagedLoggedToController() {
        let expectedMessage = "Some message"
        let expectedSeverity = LogSeverity.error

        NanoLog.e(expectedMessage)

        expect(self.controller.loggedMessage).to(equal(expectedMessage))
        expect(self.controller.loggedSeverity?.severity).to(equal(expectedSeverity.severity))
    }

    func test_whenError_thenErrorMessagedLoggedToController() {
        let expectedMessage = "Some message"
        let expectedSeverity = LogSeverity.error

        NanoLog.error(expectedMessage)

        expect(self.controller.loggedMessage).to(equal(expectedMessage))
        expect(self.controller.loggedSeverity?.severity).to(equal(expectedSeverity.severity))
    }

    func test_whenMessage_thenMessageLoggedToController() {
        let expectedMessage = "Some message"
        let expectedSeverity = LogSeverity.warning

        NanoLog.message(expectedMessage, withSeverity: expectedSeverity)

        expect(self.controller.loggedMessage).to(equal(expectedMessage))
        expect(self.controller.loggedSeverity?.severity).to(equal(expectedSeverity.severity))
    }

    func test_whenWithLoggingTag_thenTagSetOnController() {
        let expectedTag = "some-special-tag"

        NanoLog.withLoggingTag(expectedTag)

        expect(self.controller.loggedTag).to(equal(expectedTag))
    }

    func test_whenWithLoggingLane_thenLaneSetOnController() {
        NanoLog.withLoggingLane(NanoLoggingLane())

        expect(self.controller.loggedLane).toNot(beNil())
    }

    func test_whenWithDefaultConsoleLane_thenLaneSetOnController() {
        NanoLog.withDefaultConsoleLane()
        controller.loggedLane?.deliver(message: "",
                                       withSeverity: LogSeverity.debug,
                                       withTag: "",
                                       forFile: "",
                                       forFunction: "",
                                       forLine: 0)

        expect(self.controller.loggedLane).toNot(beNil())
    }
}

extension NanoLogTests {
    static var allTests = [
        ("test_whenV_thenVerboseMessageLoggedToController", test_whenV_thenVerboseMessageLoggedToController),
        ("test_whenVerbose_thenVerboseMessageLoggedToController", test_whenVerbose_thenVerboseMessageLoggedToController),
        ("test_whenD_thenDebugMessageLoggedToController", test_whenD_thenDebugMessageLoggedToController),
        ("test_whenDebug_thenDebugMessageLoggedToController", test_whenDebug_thenDebugMessageLoggedToController),
        ("test_whenI_thenInfoMessageLoggedToController", test_whenI_thenInfoMessageLoggedToController),
        ("test_whenInfo_thenInfoMessageLoggedToController", test_whenInfo_thenInfoMessageLoggedToController),
        ("test_whenW_thenWarningMessageLoggedToController", test_whenW_thenWarningMessageLoggedToController),
        ("test_whenWarning_thenWarningMessagedLoggedToController", test_whenWarning_thenWarningMessagedLoggedToController),
        ("test_whenE_thenErrorMessagedLoggedToController", test_whenE_thenErrorMessagedLoggedToController),
        ("test_whenError_thenErrorMessagedLoggedToController", test_whenError_thenErrorMessagedLoggedToController),
        ("test_whenMessage_thenMessageLoggedToController", test_whenMessage_thenMessageLoggedToController),
        ("test_whenWithLoggingTag_thenTagSetOnController", test_whenWithLoggingTag_thenTagSetOnController),
        ("test_whenWithLoggingLane_thenLaneSetOnController", test_whenWithLoggingLane_thenLaneSetOnController),
        ("test_whenWithDefaultConsoleLane_thenLaneSetOnController", test_whenWithDefaultConsoleLane_thenLaneSetOnController)
    ]
}
