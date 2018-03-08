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

/**
 Deliver a log message, filtered using a `LogFilter`, then formatted using a `LogFormat` and finally outputted using a
 `LogPrinter`.

 This is the provided implementation of `LoggingLane` and the easiest way to interact with the NanoLog framework. You
 can customise the logging behaviour by choosing a `LogFilter`, `LogFormat` and `LogPrinter` or by creating your own
 implementation of `LoggingLane`. It is suggested you use `NanoLoggingLane` in order to get the most benefit from the
 framework.
 */
public struct NanoLoggingLane {
    private let filter: LogFilter
    private let format: LogFormat
    private let printer: LogPrinter

    // MARK: Initializers

    /**
     Create a `NanoLoggingLane` using the specified `LogFilter`, `LogFormat` and `LogPrinter`.

     - parameter filter: The filter to select whether a message is logged.
     - parameter format: The format to output messages with.
     - parameter printer: How to output messages.
     */
    public init(filter: LogFilter = NanoLoggingLane.defaultFilter(),
                format: LogFormat = NanoLoggingLane.defaultFormat(),
                printer: LogPrinter = NanoLoggingLane.defaultPrinter()) {

        self.filter = filter
        self.format = format
        self.printer = printer
    }
}

// MARK: - LoggingLane
extension NanoLoggingLane: LoggingLane {

    // MARK: Logging

    /**
     Deliver a log message to an output location.

     If the specified `LogFilter` passes, then the message is formatted using the specified `LogFormat` and then
     outputted using the specified `LogPrinter`.

     - parameter message: The message to be logged.
     - parameter severity: The severity the message is logged at.
     - parameter tag: The tag attached to a particular message.
     - parameter file: The file the log call came from.
     - parameter function: The function the log call came from.
     - parameter line: The line number of the log call.
     */
    public func deliver(message: @autoclosure () -> Any,
                        withSeverity severity: LogSeverity,
                        withTag tag: String,
                        forFile file: String,
                        forFunction function: String,
                        forLine line: Int) {
        if filter.isLoggable(atSeverity: severity, withTag: tag) {
            let formattedMessage = format.formattedMessage(from: message,
                                                           withSeverity: severity,
                                                           withTag: tag,
                                                           forFile: file,
                                                           forFunction: function,
                                                           forLine: line)
            printer.printMessage(formattedMessage)
        }
    }
}

extension NanoLoggingLane {

    // MARK: Default configuration

    /**
     The default `LogFilter`, which is an `OpenLogFilter`.

     - returns: The default `LogFilter`.
     */
    public static func defaultFilter() -> LogFilter {
        return OpenLogFilter()
    }

    /**
     The default `LogFormat`, which is a `PrettyLogFormat` using its default components.

     - returns: The default `LogFormat`.
     */
    public static func defaultFormat() -> LogFormat {
        return PrettyLogFormat()
    }

    /**
     The default `LogPrinter`, which is a `ConsolePrinter`.

     - returns: The default `LogPrinter`.
     */
    public static func defaultPrinter() -> LogPrinter {
        return ConsolePrinter()
    }
}
