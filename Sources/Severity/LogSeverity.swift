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
 A representation of how severe a particular log message is.

 Log messages can be logged at different severity levels, which aids with readability of logging output and helps with
 filtering for the relevant log messages. The severity can be used in the formatted output to highlight messages at the
 different serverity levels.
 */
public struct LogSeverity {

    // MARK: Severities

    /**
     The verbose severity is intended for detailed information, generally during development. These will often be short
     term, but may remain in the app if useful for tracing some particular behaviour or functionality.

     This can be reassigned to customise the severity value, label or icon.
     */
    public static var verbose = LogSeverity(severity: 100, label: "VERBOSE", icon: "⬛")

    /**
     Debug severity is intended for developer information when debugging a particular issue or general app behaviour.
     These logs may remain in order to help with debugging future issues.

     This can be reassigned to customise the severity value, label or icon.
     */
    public static var debug = LogSeverity(severity: 200, label: "DEBUG  ", icon: "🔵")

    /**
     Info severity is informational logging, generally to document important business processes. They can be used to
     work out what an application is doing, as opposed to just debugging a particular issue.

     This can be reassigned to customise the severity value, label or icon.
     */
    public static var info = LogSeverity(severity: 300, label: "INFO   ", icon: "💚")

    /**
     Warning severity is for logging potential issues. They should signify things that allow the app to continue, but
     that extra caution should be taken.

     This can be reassigned to customise the severity value, label or icon.
     */
    public static var warning = LogSeverity(severity: 400, label: "WARNING", icon: "🔶")

    /**
     Error severity is for logging errors that should be looked into immediately. They are a sign that something has
     gone wrong and that the behaviour was unexpected.

     This can be reassigned to customise the severity value, label or icon.
     */
    public static var error = LogSeverity(severity: 500, label: "ERROR  ", icon: "🛑")

    // MARK: Properties

    /// The severity value, used for ordering severity levels.
    let severity: Int

    /// The severity label.
    let label: String

    /// The severity icon, by default a coloured emoji. Useful for adding colour to the console output.
    let icon: String

    // MARK: Initializers

    /**
     Create a `LogSeverity`.

     - parameter severity: The severity value.
     - parameter label: The severity label.
     - parameter icon: The severity icon.
     */
    public init(severity: Int, label: String, icon: String) {
        self.severity = severity
        self.label = label
        self.icon = icon
    }
}

// MARK: - Comparable
extension LogSeverity: Comparable {

    // MARK: Comparing

    /**
     Whether two `LogSeverity` instances are equivalent.

     - parameter lhs: The first instance.
     - parameter rhs: The second instance.

     - returns: Whether the two instances are equivalent.
     */
    public static func ==(lhs: LogSeverity, rhs: LogSeverity) -> Bool {
        return lhs.severity == rhs.severity &&
            lhs.label == rhs.label &&
            lhs.icon == rhs.icon
    }

    /**
     Whether the first `LogSeverity` is less than the second. This is used for ordering the severity levels.

     - parameter lhs: The first instance.
     - parameter rhs: The second instance.

     - returns: Whether the first instance is less than the second.
     */
    public static func <(lhs: LogSeverity, rhs: LogSeverity) -> Bool {
        return lhs.severity < rhs.severity
    }
}
