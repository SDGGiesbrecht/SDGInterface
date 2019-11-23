<!--
 README.md

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 -->

macOS • Linux • iOS • watchOS • tvOS

[Documentation](https://sdggiesbrecht.github.io/SDGInterface/%F0%9F%87%A8%F0%9F%87%A6EN)

# SDGInterface

SDGInterface provides tools for implementing a graphical user interface.

> [Καὶ ὁ Λόγος σὰρξ ἐγένετο καὶ ἐσκήνωσεν ἐν ἡμῖν, καὶ ἐθεασάμεθα τὴν δόξαν αὐτοῦ, δόξαν ὡς μονογενοῦς παρὰ πατρός, πλήρης χάριτος καὶ ἀληθείας.](https://www.biblegateway.com/passage/?search=John+1&version=SBLGNT;NIV)
>
> [And the Word became flesh and dwelt among us and we have watched His glory, the glory of the Only Begotten of the Father, full of grace and truth.](https://www.biblegateway.com/passage/?search=John+1&version=SBLGNT;NIV)
>
> ―‎יוחנן⁩/Yoẖanan

### Features

- API unification accross platforms.
- Localized menu bar.

### Example Usage

```swift
import SDGApplication

internal class SystemMediator: SDGApplication.SystemMediator {

  internal func finishLaunching(_ details: LaunchDetails) -> Bool {
    Application.setSamplesUp()
    return true
  }
}
```

```swift
Application.main(mediator: SystemMediator())
```

## Importing

SDGInterface provides libraries for use with the [Swift Package Manager](https://swift.org/package-manager/).

Simply add SDGInterface as a dependency in `Package.swift` and specify which of the libraries to use:

```swift
let package = Package(
    name: "MyPackage",
    dependencies: [
        .package(url: "https://github.com/SDGGiesbrecht/SDGInterface", .upToNextMinor(from: Version(0, 4, 0))),
    ],
    targets: [
        .target(name: "MyTarget", dependencies: [
            .productItem(name: "SDGApplication", package: "SDGInterface"),
            .productItem(name: "SDGMenuBar", package: "SDGInterface"),
            .productItem(name: "SDGContextMenu", package: "SDGInterface"),
            .productItem(name: "SDGErrorMessages", package: "SDGInterface"),
            .productItem(name: "SDGMenus", package: "SDGInterface"),
            .productItem(name: "SDGPopOvers", package: "SDGInterface"),
            .productItem(name: "SDGWindows", package: "SDGInterface"),
            .productItem(name: "SDGTables", package: "SDGInterface"),
            .productItem(name: "SDGProgressIndicators", package: "SDGInterface"),
            .productItem(name: "SDGButtons", package: "SDGInterface"),
            .productItem(name: "SDGImageDisplay", package: "SDGInterface"),
            .productItem(name: "SDGTextDisplay", package: "SDGInterface"),
            .productItem(name: "SDGViews", package: "SDGInterface"),
            .productItem(name: "SDGKeyboard", package: "SDGInterface"),
            .productItem(name: "SDGInterfaceBasics", package: "SDGInterface"),
        ])
    ]
)
```

The modules can then be imported in source files:

```swift
import SDGApplication
import SDGMenuBar
import SDGContextMenu
import SDGErrorMessages
import SDGMenus
import SDGPopOvers
import SDGWindows
import SDGTables
import SDGProgressIndicators
import SDGButtons
import SDGImageDisplay
import SDGTextDisplay
import SDGViews
import SDGKeyboard
import SDGInterfaceBasics
```

## About

The SDGInterface project is maintained by Jeremy David Giesbrecht.

If SDGInterface saves you money, consider giving some of it as a [donation](https://paypal.me/JeremyGiesbrecht).

If SDGInterface saves you time, consider devoting some of it to [contributing](https://github.com/SDGGiesbrecht/SDGInterface) back to the project.

> [Ἄξιος γὰρ ὁ ἐργάτης τοῦ μισθοῦ αὐτοῦ ἐστι.](https://www.biblegateway.com/passage/?search=Luke+10&version=SBLGNT;NIV)
>
> [For the worker is worthy of his wages.](https://www.biblegateway.com/passage/?search=Luke+10&version=SBLGNT;NIV)
>
> ―‎ישוע/Yeshuʼa
