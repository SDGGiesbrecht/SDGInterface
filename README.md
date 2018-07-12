<!--
 README.md

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface/SDGInterface

 Copyright ©2018 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 -->

[🇨🇦EN](Documentation/🇨🇦EN%20Read%20Me.md) <!--Skip in Jazzy-->

macOS • iOS • watchOS • tvOS

APIs: [SDGInterface](https://sdggiesbrecht.github.io/SDGInterface/SDGInterface) • [SDGApplication](https://sdggiesbrecht.github.io/SDGInterface/SDGApplication)

# SDGInterface

SDGInterface provides tools for implementing a graphical user interface.

> [Καὶ ὁ Λόγος σὰρξ ἐγένετο καὶ ἐσκήνωσεν ἐν ἡμῖν, καὶ ἐθεασάμεθα τὴν δόξαν αὐτοῦ, δόξαν ὡς μονογενοῦς παρὰ πατρός, πλήρης χάριτος καὶ ἀληθείας.<br>And the Word became flesh and dwelt among us and we have watched His glory, the glory of the Only Begotten of the Father, full of grace and truth.](https://www.biblegateway.com/passage/?search=John+1&version=SBLGNT;NIV)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;―‎יוחנן/Yoẖanan

## Features

- API unification accross platforms.

(For a list of related projects, see [here](Documentation/🇨🇦EN%20Related%20Projects.md).) <!--Skip in Jazzy-->

## Importing

SDGInterface provides libraries for use with the [Swift Package Manager](https://swift.org/package-manager/).

Simply add SDGInterface as a dependency in `Package.swift` and specify which of the libraries to use:

```swift
let package = Package(
    name: "MyPackage",
    dependencies: [
        .package(url: "https://github.com/SDGGiesbrecht/SDGInterface", .upToNextMinor(from: Version(0, 0, 0))),
    ],
    targets: [
        .target(name: "MyTarget", dependencies: [
            .productItem(name: "SDGInterface", package: "SDGInterface"),
            .productItem(name: "SDGApplication", package: "SDGInterface"),
        ])
    ]
)
```

The libraries’ modules can then be imported in source files:

```swift
import SDGInterface
import SDGApplication
```

## Example Usage

```swift
public final class SampleApplicationDelegate : ApplicationDelegate {

    public override func applicationDidFinishLaunching() {
        super.applicationDidFinishLaunching()
        setUpSamples()
    }
}
```

## About

The SDGInterface project is maintained by Jeremy David Giesbrecht.

If SDGInterface saves you money, consider giving some of it as a [donation](https://paypal.me/JeremyGiesbrecht).

If SDGInterface saves you time, consider devoting some of it to [contributing](https://github.com/SDGGiesbrecht/SDGInterface) back to the project.

> [Ἄξιος γὰρ ὁ ἐργάτης τοῦ μισθοῦ αὐτοῦ ἐστι.<br>For the worker is worthy of his wages.](https://www.biblegateway.com/passage/?search=Luke+10&version=SBLGNT;NIV)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;―‎ישוע/Yeshuʼa
