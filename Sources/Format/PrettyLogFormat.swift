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
    static let defaultDateFormat = "HH:mm:ss.SSS"

    private let components: [LogFormatComponent]

    init(withComponents components: [LogFormatComponent] = PrettyLogFormat.defaultFormat()) {
        self.components = components
    }
}

extension PrettyLogFormat: LogFormat {
    public func formattedMessage(from message: @autoclosure () -> Any,
                          withSeverity severity: LogSeverity,
                          withTag tag: String,
                          forFile file: String,
                          forFunction function: String,
                          forLine line: Int) -> String {
        var formattedMessage = ""
        for component in components {
            switch component {
            case .date(let dateFormat):
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = dateFormat
                let date = dateFormatter.string(from: Date())
                formattedMessage += date
            case .file(let withExtension):
                if withExtension {
                    formattedMessage += fileNameOfFile(file)
                } else {
                    formattedMessage += fileNameWithoutExtension(file)
                }
            case .function(let withArgs):
                if withArgs {
                    formattedMessage += function
                } else {
                    formattedMessage += stripParameters(fromFunction: function)
                }
            case .lineNumber:
                formattedMessage += "\(line)"
            case .message:
                formattedMessage += "\(message())"
            case .separator(let string):
                formattedMessage += string
            case .severity(let withFormat):
                switch withFormat {
                case .icon:
                    break
                case .label:
                    formattedMessage += severity.label
                case .letter:
                    if let firstCharacter = severity.label.first {
                        formattedMessage += String(firstCharacter)
                    }
                case .value:
                    formattedMessage += "\(severity.severity)"
                }
            case .tag:
                formattedMessage += tag
            case .thread:
                break
            }
        }
        return formattedMessage
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

    private func fileNameWithoutExtension(_ file: String) -> String {
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
            return function.substringCompat(upToEndIndex: indexOfBrace)
        }
        return function
    }
}

private extension PrettyLogFormat {
    private static func defaultFormat() -> [LogFormatComponent] {
        return [
            .date(withDateFormat: PrettyLogFormat.defaultDateFormat),
            .separator(string: " | "),
            .tag,
            .separator(string: " | "),
            .severity(withFormat: .label),
            .separator(string: " | "),
            .file(withExtension: false),
            .separator(string: ":"),
            .function(withArgs: false),
            .separator(string: ":"),
            .lineNumber,
            .separator(string: " | "),
            .message
        ]
    }
}
