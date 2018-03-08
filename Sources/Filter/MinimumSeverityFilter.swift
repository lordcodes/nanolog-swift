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
 A `LogFilter` implementation that will only allow through messages that are logged with a severity above or equal to
 a minimum severity.
 */
public class MinimumSeverityFilter {
    private let minimumSeverity: LogSeverity

    // MARK: Initializers

    /**
     Create a `MinimumSeverityFilter` for a specified minimum severity.

     - parameter minimumSeverity: The minimum severity for which to allow messages to be logged.
     */
    public init(for minimumSeverity: LogSeverity) {
        self.minimumSeverity = minimumSeverity
    }
}

//MARK: - LogFilter
extension MinimumSeverityFilter: LogFilter {
    /**
     Specify whether a method should be logged or not.

     A message can be logged if its severity is above or equal to the minimum severity level of the
     `MinimumSeverityFilter`. The ordering is calculated using the natural ordering due to `LogSeverity`
     conforming to `Comparable`.

     - parameter severity: The severity the message is logged at.
     - parameter tag: The tag attached to a particular message.

     - returns: Whether a message should be logged, based on if its severity is above or equal to the minimum severity.
     */
    public func isLoggable(atSeverity severity: LogSeverity, withTag tag: String) -> Bool {
        return severity >= minimumSeverity
    }
}
