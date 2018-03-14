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

@testable import NanoLog

class LogControllerFake {
    var loggedTag: String?
    var loggedLanes = [LoggingLane]()
    var loggedMessage: String?
    var loggedSeverity: LogSeverity?
    var loggedFile: String?
    var loggedFunction: String?
    var loggedLine: Int?
}

// MARK: - LogController
extension LogControllerFake: LogController {
    func loggingTag(_ tag: String) {
        loggedTag = tag
    }

    func addLoggingLane(_ loggingLane: LoggingLane) {
        loggedLanes.append(loggingLane)
    }

    func removeAllLoggingLanes() {
        loggedLanes.removeAll()
    }

    public func logVerbose(_ message: @autoclosure () -> Any, file: String, function: String, line: Int) {
        logMessage(message, withSeverity: LogSeverity.verbose, file: file, function: function, line: line)
    }

    public func logDebug(_ message: @autoclosure () -> Any, file: String, function: String, line: Int) {
        logMessage(message, withSeverity: LogSeverity.debug, file: file, function: function, line: line)
    }

    public func logInfo(_ message: @autoclosure () -> Any, file: String, function: String, line: Int) {
        logMessage(message, withSeverity: LogSeverity.info, file: file, function: function, line: line)
    }

    public func logWarning(_ message: @autoclosure () -> Any, file: String, function: String, line: Int) {
        logMessage(message, withSeverity: LogSeverity.warning, file: file, function: function, line: line)
    }

    public func logError(_ message: @autoclosure () -> Any, file: String, function: String, line: Int) {
        logMessage(message, withSeverity: LogSeverity.error, file: file, function: function, line: line)
    }

    func logMessage(_ message: @autoclosure () -> Any,
                    withSeverity severity: LogSeverity,
                    file: String,
                    function: String,
                    line: Int) {
        loggedMessage = "\(message())"
        loggedSeverity = severity
        loggedFile = file
        loggedFunction = function
        loggedLine = line
    }
}
