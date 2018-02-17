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

public struct LogSeverity {
    static let verbose = LogSeverity(severity: 100, label: "VERBOSE", icon: "⬛")
    static let debug = LogSeverity(severity: 200, label: "DEBUG  ", icon: "🔵")
    static let info = LogSeverity(severity: 300, label: "INFO   ", icon: "💚")
    static let warning = LogSeverity(severity: 400, label: "WARNING", icon: "🔶")
    static let error = LogSeverity(severity: 500, label: "ERROR  ", icon: "🛑")

    let severity: Int
    let label: String
    let icon: String
}
