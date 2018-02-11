import XCTest
@testable import NanoLogTests

XCTMain([
    testCase(ClockTests.allTests),
    testCase(NanoLogControllerTests.allTests),
    testCase(NanoLoggingLaneTests.allTests),
    testCase(NanoLogTests.allTests),
    testCase(OpenLogFilterTests.allTests),
    testCase(PrettyLogFormatTests.allTests),
    testCase(StringExtensionsTests.allTests),
])
