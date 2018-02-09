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
}

// MARK: - LogController
extension NanoLogController: LogController {
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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss.SSS"
        let date = dateFormatter.string(from: Date())
        let tag = "NanoLog"
        let filename = fileNameWithoutSuffix(file)
        let strippedFunc = stripParameters(fromFunction: function)
        print("\(date) | \(tag) | \(severity.label) | \(filename):\(strippedFunc):\(line) | \(message())")
    }

    func fileNameOfFile(_ file: String) -> String {
        let fileParts = file.components(separatedBy: "/")
        if let lastPart = fileParts.last {
            return lastPart
        }
        return ""
    }

    func fileNameWithoutSuffix(_ file: String) -> String {
        let fileName = fileNameOfFile(file)

        if !fileName.isEmpty {
            let fileNameParts = fileName.components(separatedBy: ".")
            if let firstPart = fileNameParts.first {
                return firstPart
            }
        }
        return ""
    }

    func stripParameters(fromFunction function: String) -> String {
        if let indexOfBrace = function.index(of: "(") {
            return function.substringCompat(endIndex: indexOfBrace)
        }
        return function
    }
}
