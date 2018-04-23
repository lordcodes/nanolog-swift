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
 Deliver a log message to a particular output location.

 `LoggingLane` allows you to customise how log messages are outputted, such as to the Xcode console or to a file. You
 can have messages outputted wherever you like as long as you conform to the `LoggingLane` protocol.
 */
public protocol LoggingLane {
    /**
     Deliver a log message to an output location.

     - parameter message: The message to be logged.
     - parameter severity: The severity the message is logged at.
     - parameter tag: The tag attached to a particular message.
     - parameter callSite: The call site the log call came from (e.g. file, function, line).
     */
    func deliver(_ message: @autoclosure () -> Any,
                 withSeverity severity: LogSeverity,
                 taggedWith tag: String,
                 calledAt callSite: LogCallSite)
}
