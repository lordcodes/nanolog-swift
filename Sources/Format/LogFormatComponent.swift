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
 A component of a formatted log message. `PrettyLogFormat` allows you to specify the format with which to log messages
 by providing an array of `LogFormatComponent`.
 */
public enum LogFormatComponent {
    /**
     The date and time of a log call, formatted with the specified date format.

     - parameter withDateFormat: The date format with which to output the log date and time.
     */
    case date(withDateFormat: String)

    /**
     The date and time of a log call in UTC, formatted with the specified date format.

     - parameter withDateFormat: The date format with which to output the log date and time.
     */
    case dateUtc(withDateFormat: String)

    /**
     The file the log call came from, with or without its file extension. For example, if all your code is in Swift
     you may not wish to see '.swift' for each log statement.

     - parameter withExtension: Whether to include the file extension in the output.
     */
    case file(withExtension: Bool)

    /**
     The function the log call came from, with or without its arguments.

     - parameter withArgs: Whether to include the function arguments in the output.
     */
    case function(withArgs: Bool)

    /**
     The line number the log call came from.
     */
    case lineNumber

    /**
     The log message
     */
    case message

    /**
     A separator string, which is useful for putting a separator between other components.

     - parameter string: The string to use as a separator.
     */
    case separator(string: String)

    /**
     The severity the message is logged at, formatted with the specified severity format. You may want to use multiple
     severity components, so that you can include the severity icon and label for example.

     - parameter withFormat: The format with which to output the severity.
     */
    case severity(withFormat: SeverityFormat)

    /**
     The tag attached to a particular message.
     */
    case tag
}
