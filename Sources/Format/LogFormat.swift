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
 Prepare formatted logging messages ready for being delivered.

 `LogFormat` takes log messages and their supplementary information and produces a formatted message ready for output.
 The easiest way to `LogFormat` is via `PrettyLogFormat`, where you can specify a `LogFormatComponent` sequence with
 which to build the log messages.
 */
public protocol LogFormat {
    /**
     Create a formatted log message ready for output.

     - parameter message: The message to be logged.
     - parameter severity: The severity the message is logged at.
     - parameter tag: The tag attached to a particular message.
     - parameter callSite: The call site the log call came from (e.g. file, function, line).

     - returns: The formatted log message.
     */
    func formattedMessage(from message: @autoclosure () -> Any,
                          withSeverity severity: LogSeverity,
                          taggedWith tag: String,
                          calledAt callSite: LogCallSite) -> String
}
