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

public class PrettyLogFormat {
}

extension PrettyLogFormat: LogFormat {
    public func formattedMessage(from message: @autoclosure () -> Any,
                          withSeverity severity: LogSeverity,
                          withTag tag: String,
                          forFile file: String,
                          forFunction function: String,
                          forLine line: Int) -> String {
        let formattedMessage = "\(message())"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss.SSS"
        let date = dateFormatter.string(from: Date())
        let filename = fileNameWithoutSuffix(file)
        let strippedFunc = stripParameters(fromFunction: function)
        return "\(date) | \(tag) | \(severity.label) | \(filename):\(strippedFunc):\(line) | \(formattedMessage)"
    }
}

private extension PrettyLogFormat {
    private func fileNameOfFile(_ file: String) -> String {
        let fileParts = file.components(separatedBy: "/")
        if let lastPart = fileParts.last {
            return lastPart
        }
        return ""
    }

    private func fileNameWithoutSuffix(_ file: String) -> String {
        let fileName = fileNameOfFile(file)

        if !fileName.isEmpty {
            let fileNameParts = fileName.components(separatedBy: ".")
            if let firstPart = fileNameParts.first {
                return firstPart
            }
        }
        return ""
    }

    private func stripParameters(fromFunction function: String) -> String {
        if let indexOfBrace = function.index(of: "(") {
            return function.substringCompat(endIndex: indexOfBrace)
        }
        return function
    }
}
