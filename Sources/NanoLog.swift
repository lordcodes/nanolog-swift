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

public class NanoLog {
    static var controller: LogController = NanoLogController()

    public static func v(_ message: @autoclosure () -> Any,
                  file: String = #file,
                  function: String = #function,
                  line: Int = #line) {
        verbose(message, file: file, function: function, line: line)
    }

    public static func verbose(_ message: @autoclosure () -> Any,
                        file: String = #file,
                        function: String = #function,
                        line: Int = #line) {
        controller.logVerbose(message, file: file, function: function, line: line)
    }

    public static func d(_ message: @autoclosure () -> Any,
                  file: String = #file,
                  function: String = #function,
                  line: Int = #line) {
        debug(message, file: file, function: function, line: line)
    }

    public static func debug(_ message: @autoclosure () -> Any,
                      file: String = #file,
                      function: String = #function,
                      line: Int = #line) {
        controller.logDebug(message, file: file, function: function, line: line)
    }

    public static func i(_ message: @autoclosure () -> Any,
                  file: String = #file,
                  function: String = #function,
                  line: Int = #line) {
        info(message, file: file, function: function, line: line)
    }

    public static func info(_ message: @autoclosure () -> Any,
                     file: String = #file,
                     function: String = #function,
                     line: Int = #line) {
        controller.logInfo(message, file: file, function: function, line: line)
    }

    public static func w(_ message: @autoclosure () -> Any,
                  file: String = #file,
                  function: String = #function,
                  line: Int = #line) {
        warning(message, file: file, function: function, line: line)
    }

    public static func warning(_ message: @autoclosure () -> Any,
                        file: String = #file,
                        function: String = #function,
                        line: Int = #line) {
        controller.logWarning(message, file: file, function: function, line: line)
    }

    public static func e(_ message: @autoclosure () -> Any,
                  file: String = #file,
                  function: String = #function,
                  line: Int = #line) {
        error(message, file: file, function: function, line: line)
    }

    public static func error(_ message: @autoclosure () -> Any,
                      file: String = #file,
                      function: String = #function,
                      line: Int = #line) {
        controller.logError(message, file: file, function: function, line: line)
    }

    public static func message(_ message: @autoclosure () -> Any,
                        withSeverity severity: LogSeverity,
                        file: String = #file,
                        function: String = #function,
                        line: Int = #line) {
        controller.logMessage(message, withSeverity: severity, file: file, function: function, line: line)
    }

    public static func withLoggingTag(_ tag: String) {
        controller.loggingTag(tag)
    }

    public static func withLoggingLane(_ loggingLane: LoggingLane) {
        controller.loggingLane(loggingLane)
    }

    public static func withDefaultConsoleLane() {
        withLoggingLane(NanoLoggingLane())
    }
}
