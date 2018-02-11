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

public struct NanoLoggingLane {
    private let filter: LogFilter
    private let format: LogFormat
    private let printer: LogPrinter

    init(filter: LogFilter = NanoLoggingLane.defaultFilter(),
         format: LogFormat = NanoLoggingLane.defaultFormat(),
         printer: LogPrinter = NanoLoggingLane.defaultPrinter()) {
        self.filter = filter
        self.format = format
        self.printer = printer
    }
}

extension NanoLoggingLane: LoggingLane {
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

private extension NanoLoggingLane {
    private static func defaultFilter() -> LogFilter {
        return OpenLogFilter()
    }

    private static func defaultFormat() -> LogFormat {
        return PrettyLogFormat()
    }

    private static func defaultPrinter() -> LogPrinter {
        return ConsolePrinter()
    }
}
