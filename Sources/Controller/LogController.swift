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

public protocol LogController {
    func loggingTag(_ tag: String)

    func addLoggingLane(_ loggingLane: LoggingLane)

    func removeAllLoggingLanes()

    func logVerbose(_ message: @autoclosure () -> Any, file: String, function: String, line: Int)

    func logDebug(_ message: @autoclosure () -> Any, file: String, function: String, line: Int)

    func logInfo(_ message: @autoclosure () -> Any, file: String, function: String, line: Int)

    func logWarning(_ message: @autoclosure () -> Any, file: String, function: String, line: Int)

    func logError(_ message: @autoclosure () -> Any, file: String, function: String, line: Int)

    func logMessage(_ message: @autoclosure () -> Any,
                    withSeverity severity: LogSeverity,
                    file: String,
                    function: String,
                    line: Int)
}
