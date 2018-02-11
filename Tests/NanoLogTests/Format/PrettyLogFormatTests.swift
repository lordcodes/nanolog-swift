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

class PrettyLogFormatTests: XCTestCase {
    private let clock = ClockFake()
    private let components: [LogFormatComponent] = [
        .date(withDateFormat: "HH:mm:ss"),
        .separator(string: "|"),
        .dateUtc(withDateFormat: "HH:mm"),
        .separator(string: "|"),
        .file(withExtension: true),
        .separator(string: "|"),
        .file(withExtension: false),
        .separator(string: "|"),
        .function(withArgs: true),
        .separator(string: "|"),
        .function(withArgs: false),
        .separator(string: "|"),
        .lineNumber,
        .separator(string: "|"),
        .message,
        .separator(string: "|"),
        .severity(withFormat: .label),
        .separator(string: "|"),
        .severity(withFormat: .letter),
        .separator(string: "|"),
        .severity(withFormat: .value),
        .separator(string: "|"),
        .tag
    ]
    private var format: LogFormat!

    override func setUp() {
        super.setUp()

        format = PrettyLogFormat(withComponents: components, withClock: clock)
    }
}

// MARK: - Tests
extension PrettyLogFormatTests {
    func test_whenFormattedMessage_thenMessageFormattedWithComponents() {
        clock.now = Date()
        let expectedDate = expectedDateString(forDate: clock.now!)
        let expectedUtcDate = expectedUtcDateString(forDate: clock.now!)
        let expectedMessage = "a message"
        let expectedSeverity = LogSeverity.debug
        let expectedTag = "a-tag"
        let expectedFile = "path/afile.swift"
        let expectedFunction = "afunction(arg:)"
        let expectedLine = 25
        let expectedFormattedMessage = "\(expectedDate)|\(expectedUtcDate)|afile.swift|afile|afunction(arg:)|afunction|25|a message|Debug  |D|200|a-tag"

        let actualMessage = format.formattedMessage(from: expectedMessage,
                                                    withSeverity: expectedSeverity,
                                                    withTag: expectedTag,
                                                    forFile: expectedFile,
                                                    forFunction: expectedFunction,
                                                    forLine: expectedLine)

        expect(actualMessage).to(equal(expectedFormattedMessage))
    }
}

private extension PrettyLogFormatTests {
    private func expectedDateString(forDate date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter.string(from: clock.now!)
    }

    private func expectedUtcDateString(forDate date: Date) -> String {
        let dateUtcFormatter = DateFormatter()
        dateUtcFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateUtcFormatter.dateFormat = "HH:mm"
        return dateUtcFormatter.string(from: clock.now!)
    }
}
