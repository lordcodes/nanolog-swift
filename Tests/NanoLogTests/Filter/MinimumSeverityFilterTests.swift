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

class MinimumSeverityFilterTests: XCTestCase {
    private let filter = MinimumSeverityFilter(for: LogSeverity.info)
}

// MARK: - Tests
extension MinimumSeverityFilterTests {
    func test_whenIsLoggable_thenTrue_givenEqualSeverity() {
        let result = filter.isLoggable(atSeverity: LogSeverity.info, withTag: "tag")

        expect(result).to(beTrue())
    }

    func test_whenIsLoggable_thenTrue_givenGreaterSeverity() {
        let result = filter.isLoggable(atSeverity: LogSeverity.warning, withTag: "tag")

        expect(result).to(beTrue())
    }

    func test_whenIsLoggable_thenFalse_givenLowerSeverity() {
        let result = filter.isLoggable(atSeverity: LogSeverity.verbose, withTag: "tag")

        expect(result).to(beFalse())
    }
}
