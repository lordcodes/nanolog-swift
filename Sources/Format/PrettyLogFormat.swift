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
    static let defaultSeparator = " | "
    static let defaultFileSeparator = ":"

    private static let unknown = "Unknown"

    private let components: [LogFormatComponent]
    private let clock: Clock

    init(withComponents components: [LogFormatComponent] = PrettyLogFormat.defaultFormat(),
         withClock clock: Clock = SystemClock()) {
        self.components = components
        self.clock = clock
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
            if let formattedComponent = createFormattedComponent(component,
                                                                 from: message,
                                                                 withSeverity: severity,
                                                                 withTag: tag,
                                                                 forFile: file,
                                                                 forFunction: function,
                                                                 forLine: line) {
                formattedMessage += formattedComponent
            }
        }
        return formattedMessage
    }
}

private extension PrettyLogFormat {
    private func createFormattedComponent(_ component: LogFormatComponent,
                                          from message: @autoclosure () -> Any,
                                          withSeverity severity: LogSeverity,
                                          withTag tag: String,
                                          forFile file: String,
                                          forFunction function: String,
                                          forLine line: Int) -> String? {
        switch component {
        case .date(let dateFormat):
            return createDate(withFormat: dateFormat)
        case .dateUtc(let dateFormat):
            return createUtcDate(withFormat: dateFormat)
        case .file(let withExtension):
            return createFile(file, withExtension: withExtension)
        case .function(let withArgs):
            return createFunction(function, withArgs: withArgs)
        case .lineNumber:
            return "\(line)"
        case .message:
            return "\(message())"
        case .separator(let string):
            return string
        case .severity(let withFormat):
            return createSeverity(severity, withFormat: withFormat)
        case .tag:
            return tag
        case .thread:
            break
        }
        return nil
    }

    private func createDate(withFormat dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let date = dateFormatter.string(from: clock.dateTimeNow())
        return date
    }

    private func createUtcDate(withFormat dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.dateFormat = dateFormat
        let date = dateFormatter.string(from: clock.dateTimeNow())
        return date
    }

    private func createFile(_ file: String, withExtension: Bool) -> String? {
        if withExtension {
            return fileNameOfFile(file)
        }
        return fileNameWithoutExtension(file)
    }

    private func fileNameOfFile(_ file: String) -> String {
        let fileParts = file.components(separatedBy: "/")
        return fileParts.last!
    }

    private func fileNameWithoutExtension(_ file: String) -> String {
        let fileName = fileNameOfFile(file)
        let fileNameParts = fileName.components(separatedBy: ".")
        return fileNameParts.first!
    }

    private func createFunction(_ function: String, withArgs: Bool) -> String {
        if withArgs {
            return function
        }
        return stripParameters(fromFunction: function)
    }

    private func stripParameters(fromFunction function: String) -> String {
        if let indexOfBrace = function.index(of: "(") {
            return function.substringCompat(upToEndIndex: indexOfBrace)
        }
        return function
    }

    private func createSeverity(_ severity: LogSeverity, withFormat format: SeverityFormat) -> String {
        switch format {
        case .icon:
            return PrettyLogFormat.unknown
        case .label:
            return severity.label
        case .letter:
            if let firstCharacter = severity.label.first {
                return String(firstCharacter)
            }
            return PrettyLogFormat.unknown
        case .value:
            return "\(severity.severity)"
        }
    }
}

private extension PrettyLogFormat {
    private static func defaultFormat() -> [LogFormatComponent] {
        return [
            .date(withDateFormat: PrettyLogFormat.defaultDateFormat),
            .separator(string: defaultSeparator),
            .tag,
            .separator(string: defaultSeparator),
            .severity(withFormat: .label),
            .separator(string: defaultSeparator),
            .file(withExtension: false),
            .separator(string: defaultFileSeparator),
            .function(withArgs: false),
            .separator(string: defaultFileSeparator),
            .lineNumber,
            .separator(string: defaultSeparator),
            .message
        ]
    }
}
