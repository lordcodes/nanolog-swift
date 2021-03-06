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

class OpenLogFilterTests: XCTestCase {
    private let filter = OpenLogFilter()
}

// MARK: - Tests
extension OpenLogFilterTests {
    func test_whenIsLoggable_thenTrue() {
        let actualLoggable = filter.isLoggable(at: LogSeverity.info, taggedWith: "Some tag")

        expect(actualLoggable).to(beTrue())
    }
}

#if os(Linux)
    extension OpenLogFilterTests {
        static var allTests = [
            ("test_whenIsLoggable_thenTrue", test_whenIsLoggable_thenTrue)
        ]
    }
#endif
