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
 A `LogFilter` implementation that allows all messages through. This is the default filter used in `NanoLogController`.
 */
public class OpenLogFilter {

    // MARK: Initializers

    /// Create an `OpenLogFilter`.
    public init() {
    }
}

// MARK: - LogFilter
extension OpenLogFilter: LogFilter {

    // MARK: Filtering

    /**
     Specify whether a method should be logged or not.

     All messages will be logged.

     - parameter severity: The severity the message is logged at.
     - parameter tag: The tag attached to a particular message.

     - returns: Whether a message should be logged, which is always true.
     */
    public func isLoggable(atSeverity severity: LogSeverity, withTag tag: String) -> Bool {
        return true
    }
}
