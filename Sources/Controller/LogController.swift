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

public protocol LogController {
    func v(_ message: @autoclosure () -> Any, file: String, function: String, line: Int)


//    void addAdapter(LogAdapter adapter);
//
//    Printer t(String tag);
//
//    void d(String message, Object... args);
//
//    void d(Object object);
//
//    void e(String message, Object... args);
//
//    void e(Throwable throwable, String message, Object... args);
//
//    void w(String message, Object... args);
//
//    void i(String message, Object... args);
//
//    void v(String message, Object... args);
//
//    void log(int priority, String tag, String message, Throwable throwable);
//
//    void clearLogAdapters();
}
