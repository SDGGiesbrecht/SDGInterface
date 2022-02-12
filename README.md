<!--
 README.md

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 -->

macOS • Windows • Web • CentOS • Ubuntu • tvOS • iOS • Android • Amazon Linux • watchOS

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
import Foundation

import SDGText
import SDGLocalization

import SDGInterface

#if !(os(iOS) && arch(arm))
  @available(macOS 11, tvOS 14, iOS 14, watchOS 7, *)
  extension SampleApplication: Application {}
#endif

@available(watchOS 6, *)
public struct SampleApplication: LegacyApplication {

  public init() {}

  public var applicationName: ProcessInfo.ApplicationNameResolver {
    return { form in
      switch form {
      case .english(let region):
        switch region {
        case .unitedKingdom, .unitedStates, .canada:
          return "Sample"
        }
      case .español(let preposición):
        switch preposición {
        case .ninguna:
          return "Ejemplar"
        case .de:
          return "del Ejemplar"
        }
      case .deutsch(let fall):
        switch fall {
        case .nominativ, .akkusativ, .dativ:
          return "Beispiel"
        }
      case .français(let préposition):
        switch préposition {
        case .aucune:
          return "Exemple"
        case .de:
          return "de l’Exemple"
        }

      case .ελληνικά(let πτώση):
        switch πτώση {
        case .ονομαστική:
          return "Παράδειγμα"
        case .αιτιατική:
          return "το Παράδειγμα"
        case .γενική:
          return "του Παραδείγματος"
        }
      case .עברית:
        return "דוגמה"
      }
    }
  }

  public static func main() {  // @exempt(from: tests)
    #if os(iOS) && arch(arm)
      legacyMain()
    #else
      if #available(macOS 11, tvOS 14, iOS 14, watchOS 7, *) {
        modernMain()
      } else {
        legacyMain()
      }
    #endif
  }

  public var mainWindow: Window<Label<InterfaceLocalization>, InterfaceLocalization> {
    return Window(
      type: .primary(nil),
      name: UserFacing<StrictString, InterfaceLocalization>({ localization in
        switch localization {
        case .englishCanada:
          return "Sample"
        }
      }),
      content: Label(
        UserFacing<StrictString, InterfaceLocalization>({ localization in
          switch localization {
          case .englishCanada:
            return "Hello, world!"
          }
        })
      )
    )
  }
}
```

```swift
@main extension SampleApplication {}
```

Some platforms lack certain features. The compilation conditions which appear throughout the documentation are defined as follows:

```swift
.define("PLATFORM_HAS_COCOA_INTERFACE", .when(platforms: [.macOS, .tvOS, .iOS])),
.define(
  "PLATFORM_LACKS_FOUNDATION_NS_USER_ACTIVITY",
  .when(platforms: [.windows, .wasi, .linux, .android])
),
.define("PLATFORM_LACKS_FOUNDATION_PROCESS_INFO", .when(platforms: [.wasi])),
.define("PLATFORM_LACKS_FOUNDATION_RUN_LOOP", .when(platforms: [.wasi])),
```

## Importing

SDGInterface provides libraries for use with the [Swift Package Manager](https://swift.org/package-manager/).

Simply add SDGInterface as a dependency in `Package.swift` and specify which of the libraries to use:

```swift
let package = Package(
  name: "MyPackage",
  dependencies: [
    .package(
      name: "SDGInterface",
      url: "https://github.com/SDGGiesbrecht/SDGInterface",
      .upToNextMinor(from: Version(0, 13, 1))
    ),
  ],
  targets: [
    .target(
      name: "MyTarget",
      dependencies: [
        .product(name: "SDGInterface", package: "SDGInterface"),
        .product(name: "SDGInterfaceTestUtilities", package: "SDGInterface"),
        .product(name: "SDGErrorMessages", package: "SDGInterface"),
        .product(name: "SDGProgressIndicators", package: "SDGInterface"),
        .product(name: "SDGKeyboard", package: "SDGInterface"),
      ]
    )
  ]
)
```

The modules can then be imported in source files:

```swift
import SDGInterface
import SDGInterfaceTestUtilities
import SDGErrorMessages
import SDGProgressIndicators
import SDGKeyboard
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
