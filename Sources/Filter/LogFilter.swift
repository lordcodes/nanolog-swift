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
 Filter for log messages that should be delivered to a particular logging lane. `LogFilter` allows you to selectively
 choose whether to deliver messages. For example, a common use-case would be to have messages logged to different
 locations based on their severity.
 */
public protocol LogFilter {
    /**
     Specify whether a method should be logged or not.

     - parameter severity: The severity the message is logged at.
     - parameter tag: The tag attached to a particular message.
     */
    func isLoggable(atSeverity severity: LogSeverity, withTag tag: String) -> Bool
}
