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

import Foundation

public class NanoLogController {
    private var tag: String
    private var loggingLane: LoggingLane?

    init(tag: String = "NanoLog", loggingLane: LoggingLane? = nil) {
        self.tag = tag
        self.loggingLane = loggingLane
    }
}

// MARK: - LogController
extension NanoLogController: LogController {
    public func loggingTag(_ tag: String) {
        self.tag = tag
    }

    public func loggingLane(_ loggingLane: LoggingLane) {
        self.loggingLane = loggingLane
    }

    public func logVerbose(_ message: @autoclosure () -> Any,
                           file: String = #file,
                           function: String = #function,
                           line: Int = #line) {
        logMessage(message, withSeverity: LogSeverity.verbose, file: file, function: function, line: line)
    }

    public func logDebug(_ message: @autoclosure () -> Any,
                         file: String = #file,
                         function: String = #function,
                         line: Int = #line) {
        logMessage(message, withSeverity: LogSeverity.debug, file: file, function: function, line: line)
    }

    public func logInfo(_ message: @autoclosure () -> Any,
                        file: String = #file,
                        function: String = #function,
                        line: Int = #line) {
        logMessage(message, withSeverity: LogSeverity.info, file: file, function: function, line: line)
    }

    public func logWarning(_ message: @autoclosure () -> Any,
                           file: String = #file,
                           function: String = #function,
                           line: Int = #line) {
        logMessage(message, withSeverity: LogSeverity.warning, file: file, function: function, line: line)
    }

    public func logError(_ message: @autoclosure () -> Any,
                         file: String = #file,
                         function: String = #function,
                         line: Int = #line) {
        logMessage(message, withSeverity: LogSeverity.error, file: file, function: function, line: line)
    }

    public func logMessage(_ message: @autoclosure () -> Any,
                           withSeverity severity: LogSeverity,
                           file: String = #file,
                           function: String = #function,
                           line: Int = #line) {
        loggingLane?.deliver(message: message,
                            withSeverity: severity,
                            withTag: tag,
                            forFile: file,
                            forFunction: function,
                            forLine: line)
    }
}
