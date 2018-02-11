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

class NanoLoggingLaneTests: XCTestCase {
    private var lane: LoggingLane!
    private let filter = LogFilterFake()
    private let format = PrettyLogFormat(withComponents: [.message])
    private let printer = LogPrinterFake()

    override func setUp() {
        super.setUp()

        lane = NanoLoggingLane(filter: filter, format: format, printer: printer)
    }
}

// MARK: - Tests
extension NanoLoggingLaneTests {
    func test_whenDeliver_thenNoMessagePrinted_givenLoggableFalse() {
        let expectedMessage = "a log message"
        filter.loggable = false

        lane.deliver(message: expectedMessage,
                     withSeverity: LogSeverity.verbose,
                     withTag: "",
                     forFile: "",
                     forFunction: "",
                     forLine: 0)

        expect(self.printer.messagePrinted).to(beNil())
    }

    func test_whenDeliver_thenMessagePrinted_givenLoggableTrue() {
        let expectedMessage = "a log message"
        filter.loggable = true

        lane.deliver(message: expectedMessage,
                     withSeverity: LogSeverity.verbose,
                     withTag: "",
                     forFile: "",
                     forFunction: "",
                     forLine: 0)

        expect(self.printer.messagePrinted).to(equal(expectedMessage))
    }
}

#if os(Linux)
    extension NanoLoggingLaneTests {
        static var allTests = [
            ("test_whenDeliver_thenNoMessagePrinted_givenLoggableFalse", test_whenDeliver_thenNoMessagePrinted_givenLoggableFalse),
            ("test_whenDeliver_thenMessagePrinted_givenLoggableTrue", test_whenDeliver_thenMessagePrinted_givenLoggableTrue)
        ]
    }
#endif
