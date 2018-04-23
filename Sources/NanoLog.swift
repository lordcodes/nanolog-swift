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
 `NanoLog` allows you to log messages at different severity levels. You can choose where these logs are delivered by
 registering different logging lanes. Calling `addDefaultConsoleLane()` will give you the default Xcode console setup.

 `NanoLog` can be seen as the static API to the NanoLog framework. You can also use a `LogController` instance directly
 by using `NanoLogController`.
 */
public class NanoLog {
    static var controller: LogController = NanoLogController()

    // MARK: Logging

    /**
     Log a message of verbose severity.

     The verbose severity is intended for detailed information, generally during development. These will often be short
     term, but may remain in the app if useful for tracing some particular behaviour or functionality.

     - parameter message: The message to be logged. The autoclosure will only be evaluated if the message needs to be
                          logged.
     - parameter file: The file the log call came from. You don't need to pass a value for file.
     - parameter function: The function the log call came from. You don't need to pass a value for function.
     - parameter line: The line number of the log call. You don't need to pass a value for line.
     */
    public static func v(_ message: @autoclosure () -> Any,
                         file: String = #file,
                         function: String = #function,
                         line: Int = #line) {
        verbose(message, file: file, function: function, line: line)
    }

    /**
     Log a message of verbose severity.

     Verbose severity is intended for detailed information, generally during development. These will often be short
     term, but may remain in the app if useful for tracing some particular behaviour or functionality.

     - parameter message: The message to be logged. The autoclosure will only be evaluated if the message needs to be
                          logged.
     - parameter file: The file the log call came from. You don't need to pass a value for file.
     - parameter function: The function the log call came from. You don't need to pass a value for function.
     - parameter line: The line number of the log call. You don't need to pass a value for line.
     */
    public static func verbose(_ message: @autoclosure () -> Any,
                               file: String = #file,
                               function: String = #function,
                               line: Int = #line) {
        controller.logVerbose(message, file: file, function: function, line: line)
    }

    /**
     Log a message of debug severity.

     Debug severity is intended for developer information when debugging a particular issue or general app behaviour.
     These logs may remain in order to help with debugging future issues.

     - parameter message: The message to be logged. The autoclosure will only be evaluated if the message needs to be
                          logged.
     - parameter file: The file the log call came from. You don't need to pass a value for file.
     - parameter function: The function the log call came from. You don't need to pass a value for function.
     - parameter line: The line number of the log call. You don't need to pass a value for line.
     */
    public static func d(_ message: @autoclosure () -> Any,
                         file: String = #file,
                         function: String = #function,
                         line: Int = #line) {
        debug(message, file: file, function: function, line: line)
    }

    /**
     Log a message of debug severity.

     Debug severity is intended for developer information when debugging a particular issue or general app behaviour.
     These logs may remain in order to help with debugging future issues.

     - parameter message: The message to be logged. The autoclosure will only be evaluated if the message needs to be
                          logged.
     - parameter file: The file the log call came from. You don't need to pass a value for file.
     - parameter function: The function the log call came from. You don't need to pass a value for function.
     - parameter line: The line number of the log call. You don't need to pass a value for line.
     */
    public static func debug(_ message: @autoclosure () -> Any,
                             file: String = #file,
                             function: String = #function,
                             line: Int = #line) {
        controller.logDebug(message, file: file, function: function, line: line)
    }

    /**
     Log a message of info severity.

     Info severity is informational logging, generally to document important business processes. They can be used to
     work out what an application is doing, as opposed to just debugging a particular issue.

     - parameter message: The message to be logged. The autoclosure will only be evaluated if the message needs to be
                          logged.
     - parameter file: The file the log call came from. You don't need to pass a value for file.
     - parameter function: The function the log call came from. You don't need to pass a value for function.
     - parameter line: The line number of the log call. You don't need to pass a value for line.
     */
    public static func i(_ message: @autoclosure () -> Any,
                         file: String = #file,
                         function: String = #function,
                         line: Int = #line) {
        info(message, file: file, function: function, line: line)
    }

    /**
     Log a message of info severity.

     Info severity is informational logging, generally to document important business processes. They can be used to
     work out what an application is doing, as opposed to just debugging a particular issue.

     - parameter message: The message to be logged. The autoclosure will only be evaluated if the message needs to be
                          logged.
     - parameter file: The file the log call came from. You don't need to pass a value for file.
     - parameter function: The function the log call came from. You don't need to pass a value for function.
     - parameter line: The line number of the log call. You don't need to pass a value for line.
     */
    public static func info(_ message: @autoclosure () -> Any,
                            file: String = #file,
                            function: String = #function,
                            line: Int = #line) {
        controller.logInfo(message, file: file, function: function, line: line)
    }

    /**
     Log a message of warning severity.

     Warning severity is for logging potential issues. They should signify things that allow the app to continue, but
     that extra caution should be taken.

     - parameter message: The message to be logged. The autoclosure will only be evaluated if the message needs to be
                          logged.
     - parameter file: The file the log call came from. You don't need to pass a value for file.
     - parameter function: The function the log call came from. You don't need to pass a value for function.
     - parameter line: The line number of the log call. You don't need to pass a value for line.
     */
    public static func w(_ message: @autoclosure () -> Any,
                         file: String = #file,
                         function: String = #function,
                         line: Int = #line) {
        warning(message, file: file, function: function, line: line)
    }

    /**
     Log a message of warning severity.

     Warning severity is for logging potential issues. They should signify things that allow the app to continue, but
     that extra caution should be taken.

     - parameter message: The message to be logged. The autoclosure will only be evaluated if the message needs to be
                          logged.
     - parameter file: The file the log call came from. You don't need to pass a value for file.
     - parameter function: The function the log call came from. You don't need to pass a value for function.
     - parameter line: The line number of the log call. You don't need to pass a value for line.
     */
    public static func warning(_ message: @autoclosure () -> Any,
                               file: String = #file,
                               function: String = #function,
                               line: Int = #line) {
        controller.logWarning(message, file: file, function: function, line: line)
    }

    /**
     Log a message of error severity.

     Error severity is for logging errors that should be looked into immediately. They are a sign that something has
     gone wrong and that the behaviour was unexpected.

     - parameter message: The message to be logged. The autoclosure will only be evaluated if the message needs to be
                          logged.
     - parameter file: The file the log call came from. You don't need to pass a value for file.
     - parameter function: The function the log call came from. You don't need to pass a value for function.
     - parameter line: The line number of the log call. You don't need to pass a value for line.
     */
    public static func e(_ message: @autoclosure () -> Any,
                         file: String = #file,
                         function: String = #function,
                         line: Int = #line) {
        error(message, file: file, function: function, line: line)
    }

    /**
     Log a message of error severity.

     Error severity is for logging errors that should be looked into immediately. They are a sign that something has
     gone wrong and that the behaviour was unexpected.

     - parameter message: The message to be logged. The autoclosure will only be evaluated if the message needs to be
                          logged.
     - parameter file: The file the log call came from. You don't need to pass a value for file.
     - parameter function: The function the log call came from. You don't need to pass a value for function.
     - parameter line: The line number of the log call. You don't need to pass a value for line.
     */
    public static func error(_ message: @autoclosure () -> Any,
                             file: String = #file,
                             function: String = #function,
                             line: Int = #line) {
        controller.logError(message, file: file, function: function, line: line)
    }

    /**
     Log a message with a specified severity.

     - parameter message: The message to be logged. The autoclosure will only be evaluated if the message needs to be
                          logged.
     - parameter severity: The severity to to log the message with.
     - parameter file: The file the log call came from. You don't need to pass a value for file.
     - parameter function: The function the log call came from. You don't need to pass a value for function.
     - parameter line: The line number of the log call. You don't need to pass a value for line.
     */
    public static func message(_ message: @autoclosure () -> Any,
                               withSeverity severity: LogSeverity,
                               file: String = #file,
                               function: String = #function,
                               line: Int = #line) {
        controller.logMessage(message, withSeverity: severity, file: file, function: function, line: line)
    }

    // MARK: Logging customisation

    /**
     Register a tag that can be used within logging messages. This can be useful to filter the logging output for all
     the relevant log messages.

     - parameter tag: The tag to register.
     */
    public static func register(loggingTag tag: String) {
        controller.register(loggingTag: tag)
    }

    /**
     Add a lane to deliver log messages to. Lanes allow you to customise the logging of messages. For the simplest
     approach, you can use `NanoLoggingLane` and simply choose a filter, format and printer.

     - parameter loggingLane: Lane to deliver messages to.
     */
    public static func addLoggingLane(_ loggingLane: LoggingLane) {
        controller.addLoggingLane(loggingLane)
    }

    /**
     Add the default Xcode console logging lane.
     */
    public static func addDefaultConsoleLane() {
        addLoggingLane(NanoLoggingLane())
    }

    /**
     Remove all registered logging lanes.
     */
    public static func removeAllLoggingLanes() {
        controller.removeAllLoggingLanes()
    }
}
