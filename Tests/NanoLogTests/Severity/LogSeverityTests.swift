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

class LogSeverityTests: XCTestCase {
}

// MARK: - Tests
extension LogSeverityTests {
    func test_whenEquals_thenTrue_givenSame() {
        let severity0 = LogSeverity(severity: 100, label: "a label", icon: "an icon")
        let severity1 = LogSeverity(severity: 100, label: "a label", icon: "an icon")

        let result = severity0 == severity1

        expect(result).to(beTrue())
    }

    func test_whenEquals_thenFalse_givenDifferentValue() {
        let severity0 = LogSeverity(severity: 100, label: "a label", icon: "an icon")
        let severity1 = LogSeverity(severity: 200, label: "a label", icon: "an icon")

        let result = severity0 == severity1

        expect(result).to(beFalse())
    }

    func test_whenEquals_thenFalse_givenDifferentLabel() {
        let severity0 = LogSeverity(severity: 100, label: "a label", icon: "an icon")
        let severity1 = LogSeverity(severity: 100, label: "another label", icon: "an icon")

        let result = severity0 == severity1

        expect(result).to(beFalse())
    }

    func test_whenEquals_thenFalse_givenDifferentIcon() {
        let severity0 = LogSeverity(severity: 100, label: "a label", icon: "an icon")
        let severity1 = LogSeverity(severity: 200, label: "a label", icon: "another icon")

        let result = severity0 == severity1

        expect(result).to(beFalse())
    }

    func test_whenLessThan_thenTrue_givenFirstValueLessThanSecond() {
        let severity0 = LogSeverity(severity: 100, label: "a label", icon: "an icon")
        let severity1 = LogSeverity(severity: 200, label: "a label", icon: "an icon")

        let result = severity0 < severity1

        expect(result).to(beTrue())
    }

    func test_whenLessThan_thenFalse_givenFirstValueGreaterThanSecond() {
        let severity0 = LogSeverity(severity: 200, label: "a label", icon: "an icon")
        let severity1 = LogSeverity(severity: 100, label: "a label", icon: "an icon")

        let result = severity0 < severity1

        expect(result).to(beFalse())
    }
}
