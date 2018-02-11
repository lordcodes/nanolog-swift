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
        .severity(withFormat: .icon),
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
        let expectedDate = expectedDateString(forDate: clock.now!, dateFormat: "HH:mm:ss")
        let expectedUtcDate = expectedUtcDateString(forDate: clock.now!, dateFormat: "HH:mm")
        let expectedFormattedMessage = "\(expectedDate)|\(expectedUtcDate)|afile.swift|afile|afunction(arg:)|afunction|25|a message|Unknown|Debug  |D|200|a-tag"

        let actualMessage = format.formattedMessage(from: "a message",
                                                    withSeverity: LogSeverity.debug,
                                                    withTag: "a-tag",
                                                    forFile: "path/afile.swift",
                                                    forFunction: "afunction(arg:)",
                                                    forLine: 25)

        expect(actualMessage).to(equal(expectedFormattedMessage))
    }

    func test_whenFormattedMessage_thenUnknownSeverity_givenSeverityWithEmptyLabelAndLetterSeverityFormat() {
        let severity = LogSeverity(severity: 900, label: "")
        let format = PrettyLogFormat(withComponents: [.severity(withFormat: .letter)])

        let actualMessage = format.formattedMessage(from: "",
                                                    withSeverity: severity,
                                                    withTag: "",
                                                    forFile: "",
                                                    forFunction: "",
                                                    forLine: 0)

        expect(actualMessage).to(equal("Unknown"))
    }

    func test_whenFormattedMessage_thenFunctionUnchanged_givenFunctionWithNoBrackets() {
        let format = PrettyLogFormat(withComponents: [.function(withArgs: false)])

        let actualMessage = format.formattedMessage(from: "",
                                                    withSeverity: LogSeverity.error,
                                                    withTag: "",
                                                    forFile: "",
                                                    forFunction: "somefunction",
                                                    forLine: 0)

        expect(actualMessage).to(equal("somefunction"))
    }

    func test_whenFormattedMessage_thenMessageFormattedWithDefaultFormat_givenDefaultFormat() {
        format = PrettyLogFormat(withClock: clock)
        clock.now = Date()
        let expectedDate = expectedDateString(forDate: clock.now!, dateFormat: PrettyLogFormat.defaultDateFormat)
        let expectedFormattedMessage = "\(expectedDate) | a-tag | Debug   | afile:afunction:25 | a message"

        let actualMessage = format.formattedMessage(from: "a message",
                                                    withSeverity: LogSeverity.debug,
                                                    withTag: "a-tag",
                                                    forFile: "path/afile.swift",
                                                    forFunction: "afunction(arg:)",
                                                    forLine: 25)

        expect(actualMessage).to(equal(expectedFormattedMessage))
    }
}

private extension PrettyLogFormatTests {
    private func expectedDateString(forDate date: Date, dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: clock.now!)
    }

    private func expectedUtcDateString(forDate date: Date, dateFormat: String) -> String {
        let dateUtcFormatter = DateFormatter()
        dateUtcFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateUtcFormatter.dateFormat = dateFormat
        return dateUtcFormatter.string(from: clock.now!)
    }
}
