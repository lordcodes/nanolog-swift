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
 `LogController` is the core controller of the NanoLog framework used by the static `NanoLog` API. If you would prefer
 you can use `LogController` yourself, instead of the static API, by initialising a NanoLogController instance.
 */
public protocol LogController {

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
    func logVerbose(_ message: @autoclosure () -> Any, file: String, function: String, line: Int)

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
    func logDebug(_ message: @autoclosure () -> Any, file: String, function: String, line: Int)

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
    func logInfo(_ message: @autoclosure () -> Any, file: String, function: String, line: Int)

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
    func logWarning(_ message: @autoclosure () -> Any, file: String, function: String, line: Int)

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
    func logError(_ message: @autoclosure () -> Any, file: String, function: String, line: Int)

    /**
     Log a message with a specified severity to all registered lanes.

     - parameter message: The message to be logged. The autoclosure will only be evaluated if the message needs to be
                          logged.
     - parameter severity: The severity to to log the message with.
     - parameter file: The file the log call came from. You don't need to pass a value for file.
     - parameter function: The function the log call came from. You don't need to pass a value for function.
     - parameter line: The line number of the log call. You don't need to pass a value for line.
     */
    func logMessage(_ message: @autoclosure () -> Any,
                    withSeverity severity: LogSeverity,
                    file: String,
                    function: String,
                    line: Int)

    // MARK: Logging customisation

    /**
     Register a tag that can be used within logging messages. This can be useful to filter the logging output for all
     the relevant log messages.

     - parameter tag: The tag to register.
     */
    func loggingTag(_ tag: String)

    /**
     Add a lane to deliver log messages to. Lanes allow you to customise the logging of messages. For the simplest
     approach, you can use `NanoLoggingLane` and simply choose a filter, format and printer.

     - parameter loggingLane: Lane to deliver messages to.
     */
    func addLoggingLane(_ loggingLane: LoggingLane)

    /**
     Remove all registered logging lanes.
     */
    func removeAllLoggingLanes()
}
