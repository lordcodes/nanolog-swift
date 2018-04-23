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
 `NanoLogController` is the provided implementation of `LogController`, which in turn is the core controller of the
 NanoLog framework. The controller is used by the static `NanoLog` API and can be used instead of the static API if you
 wish to.
 */
public class NanoLogController {
    private var tag: String
    private var loggingLanes: [LoggingLane]

    // MARK: Initializers

    /**
     Create a `NanoLogController` using the specified tag and logging lanes.

     - parameter tag: A tag that can be used within logging messages.
     - parameter loggingLanes: Lanes to deliver log messages to.
     */
    public init(tag: String = "NanoLog", loggingLanes: [LoggingLane] = [LoggingLane]()) {
        self.tag = tag
        self.loggingLanes = loggingLanes
    }
}

// MARK: - LogController
extension NanoLogController: LogController {

    // MARK: Logging

    /**
     Log a message of verbose severity to all registered lanes.

     The verbose severity is intended for detailed information, generally during development. These will often be short
     term, but may remain in the app if useful for tracing some particular behaviour or functionality.

     - parameter message: The message to be logged. The autoclosure will only be evaluated if the message needs to be
                          logged.
     - parameter file: The file the log call came from. You don't need to pass a value for file.
     - parameter function: The function the log call came from. You don't need to pass a value for function.
     - parameter line: The line number of the log call. You don't need to pass a value for line.
     */
    public func logVerbose(_ message: @autoclosure () -> Any,
                           file: String = #file,
                           function: String = #function,
                           line: Int = #line) {
        logMessage(message, withSeverity: LogSeverity.verbose, file: file, function: function, line: line)
    }

    /**
     Log a message of debug severity to all registered lanes.

     Debug severity is intended for developer information when debugging a particular issue or general app behaviour.
     These logs may remain in order to help with debugging future issues.

     - parameter message: The message to be logged. The autoclosure will only be evaluated if the message needs to be
                          logged.
     - parameter file: The file the log call came from. You don't need to pass a value for file.
     - parameter function: The function the log call came from. You don't need to pass a value for function.
     - parameter line: The line number of the log call. You don't need to pass a value for line.
     */
    public func logDebug(_ message: @autoclosure () -> Any,
                         file: String = #file,
                         function: String = #function,
                         line: Int = #line) {
        logMessage(message, withSeverity: LogSeverity.debug, file: file, function: function, line: line)
    }

    /**
     Log a message of info severity to all registered lanes.

     Info severity is informational logging, generally to document important business processes. They can be used to
     work out what an application is doing, as opposed to just debugging a particular issue.

     - parameter message: The message to be logged. The autoclosure will only be evaluated if the message needs to be
                          logged.
     - parameter file: The file the log call came from. You don't need to pass a value for file.
     - parameter function: The function the log call came from. You don't need to pass a value for function.
     - parameter line: The line number of the log call. You don't need to pass a value for line.
     */
    public func logInfo(_ message: @autoclosure () -> Any,
                        file: String = #file,
                        function: String = #function,
                        line: Int = #line) {
        logMessage(message, withSeverity: LogSeverity.info, file: file, function: function, line: line)
    }

    /**
     Log a message of warning severity to all registered lanes.

     Warning severity is for logging potential issues. They should signify things that allow the app to continue, but
     that extra caution should be taken.

     - parameter message: The message to be logged. The autoclosure will only be evaluated if the message needs to be
                          logged.
     - parameter file: The file the log call came from. You don't need to pass a value for file.
     - parameter function: The function the log call came from. You don't need to pass a value for function.
     - parameter line: The line number of the log call. You don't need to pass a value for line.
     */
    public func logWarning(_ message: @autoclosure () -> Any,
                           file: String = #file,
                           function: String = #function,
                           line: Int = #line) {
        logMessage(message, withSeverity: LogSeverity.warning, file: file, function: function, line: line)
    }

    /**
     Log a message of error severity to all registered lanes.

     Error severity is for logging errors that should be looked into immediately. They are a sign that something has
     gone wrong and that the behaviour was unexpected.

     - parameter message: The message to be logged. The autoclosure will only be evaluated if the message needs to be
                          logged.
     - parameter file: The file the log call came from. You don't need to pass a value for file.
     - parameter function: The function the log call came from. You don't need to pass a value for function.
     - parameter line: The line number of the log call. You don't need to pass a value for line.
     */
    public func logError(_ message: @autoclosure () -> Any,
                         file: String = #file,
                         function: String = #function,
                         line: Int = #line) {
        logMessage(message, withSeverity: LogSeverity.error, file: file, function: function, line: line)
    }

    /**
     Log a message with a specified severity to all registered lanes.

     - parameter message: The message to be logged. The autoclosure will only be evaluated if the message needs to be
                          logged.
     - parameter severity: The severity to to log the message with.
     - parameter file: The file the log call came from. You don't need to pass a value for file.
     - parameter function: The function the log call came from. You don't need to pass a value for function.
     - parameter line: The line number of the log call. You don't need to pass a value for line.
     */
    public func logMessage(_ message: @autoclosure () -> Any,
                           withSeverity severity: LogSeverity,
                           file: String = #file,
                           function: String = #function,
                           line: Int = #line) {

        for lane in loggingLanes {
            lane.deliver(message,
                         withSeverity: severity,
                         taggedWith: tag,
                         calledAt: LogCallSite(file: file, function: function, line: line))
        }
    }

    // MARK: Logging customisation

    /**
     Register a tag that can be used within logging messages. This can be useful to filter the logging output for all
     the relevant log messages.

     - parameter tag: The tag to register.
     */
    public func register(loggingTag tag: String) {
        self.tag = tag
    }

    /**
     Add a lane to deliver log messages to. Lanes allow you to customise the logging of messages. For the simplest
     approach, you can use `NanoLoggingLane` and simply choose a filter, format and printer.

     - parameter loggingLane: Lane to deliver messages to.
     */
    public func addLoggingLane(_ loggingLane: LoggingLane) {
        loggingLanes.append(loggingLane)
    }

    /**
     Remove all registered logging lanes.
     */
    public func removeAllLoggingLanes() {
        loggingLanes.removeAll()
    }
}
