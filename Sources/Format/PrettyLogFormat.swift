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

/**
 Prepare formatted logging messages ready for being delivered.

 By providing a sequence of `LogFormatComponent`s, `PrettyLogFormat` produces formatted log messages ready for output.
 */
public class PrettyLogFormat {

    // MARK: Constants

    /// The default format with which to output dates.
    static let defaultDateFormat = "HH:mm:ss.SSS"

    /// The default separator to use between log components.
    static let defaultSeparator = " | "

    /// The default separator to use between the file, function and line number log components.
    static let defaultFileSeparator = ":"

    private static let unknown = "Unknown"

    private let components: [LogFormatComponent]
    private let clock: Clock

    // MARK: Initializers

    /**
     Create a `PrettyLogFormat`, which uses the specified sequence of `LogFormatComponent`s to output log messages.

     - parameter components: The components to use in the output. There is a default format provided.
     */
    public convenience init(withComponents components: [LogFormatComponent] = PrettyLogFormat.defaultFormat()) {
        self.init(withComponents: components, withClock: SystemClock())
    }

    init(withComponents components: [LogFormatComponent], withClock clock: Clock) {
        self.components = components
        self.clock = clock
    }
}

// MARK: - LogFormat
extension PrettyLogFormat: LogFormat {

    // MARK: Formatting

    /**
     Create a formatted log message ready for output, using the specified sequence of `LogFormatComponent`s.

     - parameter message: The message to be logged.
     - parameter severity: The severity the message is logged at.
     - parameter tag: The tag attached to a particular message.
     - parameter file: The file the log call came from.
     - parameter function: The function the log call came from.
     - parameter line: The line number of the log call.

     - returns: The formatted log message.
     */
    public func formattedMessage(from message: @autoclosure () -> Any,
                                 withSeverity severity: LogSeverity,
                                 taggedWith tag: String,
                                 calledAt callSite: LogCallSite) -> String {

        var formattedMessage = ""
        for component in components {
            if let formattedComponent = createFormattedComponent(component,
                                                                 from: message,
                                                                 withSeverity: severity,
                                                                 taggedWith: tag,
                                                                 calledAt: callSite) {
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
                                          taggedWith tag: String,
                                          calledAt callSite: LogCallSite) -> String? {
        switch component {
        case .date(let dateFormat):
            return createDate(withFormat: dateFormat)
        case .dateUtc(let dateFormat):
            return createUtcDate(withFormat: dateFormat)
        case .file(let withExtension):
            return createFile(callSite.file, withExtension: withExtension)
        case .function(let withArgs):
            return createFunction(callSite.function, withArgs: withArgs)
        case .lineNumber:
            return "\(callSite.line)"
        case .message:
            return "\(message())"
        case .separator(let string):
            return string
        case .severity(let withFormat):
            return createSeverity(severity, withFormat: withFormat)
        case .tag:
            return tag
        }
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
            return severity.icon
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

public extension PrettyLogFormat {
    /**
     The default output format.

     - returns: The sequence of `LogFormatComponent`s in the default output format.
     */
    public static func defaultFormat() -> [LogFormatComponent] {
        return [
            .date(withDateFormat: PrettyLogFormat.defaultDateFormat),
            .separator(string: defaultSeparator),
            .tag,
            .separator(string: defaultSeparator),
            .severity(withFormat: .icon),
            .separator(string: " "),
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
