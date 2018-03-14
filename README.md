# NanoLog

[![Build Status](https://travis-ci.org/andrewlord1990/nanolog-swift.svg?branch=master)](https://travis-ci.org/andrewlord1990/nanolog-swift)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![CocoaPods compatible](https://img.shields.io/cocoapods/v/NanoLog.svg)](https://cocoapods.org/pods/NanoLog)
[![Swift Package Manager](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://github.com/andrewlord1990/nanolog-swift/blob/master/LICENSE)

A **powerful** and **extensible** logging framework for Swift that is **small** and **easy** to use!

![Console logging](web/img/example-console-output.png)

***

## Platform support

- Swift 4+
- Apple platforms:
  - iOS 8.0+
  - MacOS 10.10+
  - tvOS 9.0+
  - watchOS 2.0+

## Installation

### Dependency Managers

<details>
  <summary><strong>Carthage</strong></summary>
  <p>

You can use [Carthage](https://github.com/Carthage/Carthage) to integrate NanoLog into your Xcode project.

To do so, simply specify the dependency in your `Cartfile`:

```ogdl
github "andrewlord1990/NanoLog" == '0.0.1'
```

</p>
</details>

<details>
  <summary><strong>CocoaPods</strong></summary>
  <p>

You can use [CocoaPods](http://cocoapods.org) to integrate NanoLog into your Xcode project.

To do so, simply specify the dependency in your `Podfile`:

```ruby
pod 'NanoLog', '0.0.1'
```

</p>
</details>

<details>
  <summary><strong>Swift Package Manager</strong></summary>
  <p>

You can use [Swift Package Manager](https://swift.org/package-manager/) to integrate NanoLog into your project.

To do so, simply specify the dependency in your `Package.swift`:

```swift
.package(url: "https://github.com/andrewlord1990/nanolog-swift.git", .exact("0.0.1"))
```

</p>
</details>

### Manually

If you prefer not to use any of the dependency managers, you can integrate NanoLog manually.

<details>
  <summary><strong>Embedded Framework</strong></summary>
  <p>

- Download the latest release from [Releases](https://github.com/andrewlord1990/nanolog-swift/releases)
- Store the downloaded framework somewhere accessible
- Open your app project file in the Project Navigator
- Select your app target under the "Targets" heading in the sidebar
- Open the "General" tab
- Click on the `+` button under the "Embedded Binaries" section
- Add the downloaded `NanoLog.framework`

If you had already added another version of NanoLog, make sure to replace it with the new version.

  </p>
</details>

<details>
  <summary><strong>Git Submodules</strong></summary>
  <p>

- Open up Terminal, or your preferred console application
- `cd` to the top-level of your project directory
- If your project is not already a Git repository, run:

```bash
$ git init
```

- Add NanoLog as a Git [submodule](http://git-scm.com/docs/git-submodule) by running:

```bash
$ git submodule add https://github.com/andrewlord1990/nanolog-swift.git
$ git submodule update --init --recursive
```

- Open the `NanoLog` folder, and drag the `NanoLog.xcodeproj` into the Project Navigator of your Xcode project.
- Select the `NanoLog.xcodeproj` in the Project Navigator and verify the deployment target matches that of your application target.
- Next, open your app project file in the Project Navigator
- Select your app target under the "Targets" heading in the sidebar
- Open the "General" tab
- Click on the `+` button under the "Embedded Binaries" section
- You will see two different `NanoLog.xcodeproj` folders each with two different versions of the `NanoLog.framework` nested inside a `Products` folder.

    > It does not matter which `Products` folder you choose from.

- Select the `NanoLog.framework`.

> The `NanoLog.framework` is automatically added as a target dependency, linked framework and embedded framework in a copy files build phase which is all you need to build on the simulator and a device.

</p>
</details>

## Contributing

Issues and pull requests are welcome!

## Author

Andrew Lord [@andrewlord1990](https://twitter.com/@andrewlord1990)

## License

NanoLog is released under the Apache 2.0 license. See [LICENSE](https://github.com/andrewlord1990/nanolog-swift/blob/master/LICENSE) for details.
