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

import NanoLog
import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        NanoLog.error("A really important error")
        NanoLog.w("Something you should probably look into")
        anotherMethod(withString: "testing")
        someMethod(withIntArg: 2)
        NanoLog.message("A general concern", withSeverity: .concern)
        NanoLog.concern("A general concern")
    }

    func anotherMethod(withString string: String) {
        NanoLog.info("Some useful information")
        NanoLog.d("Some debugging data that contains the argument: \(string)")
    }

    func someMethod(withIntArg intArg: Int) {
        NanoLog.verbose("Something verbose")
    }
}
