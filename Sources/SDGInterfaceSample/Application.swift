/*
 Application.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.2.2, Web doesn’t have Foundation yet.)
#if !os(WASI)
  import Foundation
#endif
#if canImport(AppKit)
  import AppKit
#endif
#if canImport(UIKit)
  import UIKit
#endif

import SDGControlFlow
import SDGMathematics
import SDGText
import SDGLocalization

import SDGInterfaceBasics
import SDGViews
import SDGTextDisplay
import SDGImageDisplay
import SDGButtons
import SDGWindows
import SDGErrorMessages
import SDGMenuBar
import SDGApplication

extension Application {

  public static func setUp() {
    // #workaround(Swift 5.2.2, Web doesn’t have Foundation yet.)
    #if !os(WASI)
      ProcessInfo.applicationName = { form in
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
    #endif
  }

  #if !os(watchOS)
    // #workaround(Swift 5.2.2, Web doesn’t have Foundation yet.)
    #if !os(WASI)
      public class func setUpAndMain() -> Never {  // @exempt(from: tests)
        setUp()
        // @example(main)
        Application.main(mediator: SystemMediator())
        // @endExample
      }
    #endif
  #endif

  internal static func setSamplesUp() {
    Application.shared.preferenceManager = PreferenceManager()
    setMenuUp()
  }

  private static func setMenuUp() {
    #if canImport(AppKit)
      MenuBar.menuBar.setSamplesUp()
    #endif

    #if canImport(UIKit) && !os(watchOS) && !os(tvOS)
      let editor = TextEditor()
      let window = Window.primaryWindow(
        name: .static(ApplicationNameForm.localizedIsolatedForm),
        view: editor.cocoa()
      )
      if ProcessInfo.processInfo
        .environment["XCTestConfigurationFilePath"] == nil
      {  // #exempt(from: tests)
        // This call fails during tests.
        window.display()
      }
    #endif
  }

  #if (canImport(AppKit) || canImport(UIKit)) && !os(watchOS)
    private func demonstrate(_ window: AnyWindow) {
      window.display()
    }
    private func demonstrate<V, L>(_ view: V, windowTitle: UserFacing<StrictString, L>)
    where V: LegacyView {
      #if canImport(AppKit)
        let window = Window<L>.auxiliaryWindow(
          name: .static(windowTitle),
          view: view.padding().cocoa()
        )
        demonstrate(window)
      #else
        let window = Window(name: .static(windowTitle), view: view.padding().cocoa())
        demonstrate(window)
      #endif
    }

    @objc public func demonstrateButton() {
      let label = UserFacing<StrictString, InterfaceLocalization>({ localization in
        switch localization {
        case .englishCanada:
          return "Button"
        }
      })
      demonstrate(
        Button(
          label: label,
          action: {
            // @exempt(from: tests)
            print(
              UserFacing<StrictString, InterfaceLocalization>({ localization in
                switch localization {
                case .englishCanada:
                  return "Button pressed."
                }
              })
            )
          }
        ),
        windowTitle: label
      )
    }

    @objc public func demonstrateCheckBox() {
      #if canImport(AppKit)
        let label = UserFacing<StrictString, InterfaceLocalization>({ localization in
          switch localization {
          case .englishCanada:
            return "Check Box"
          }
        })
        demonstrate(CheckBox(label: label, isChecked: Shared(false)), windowTitle: label)
      #endif
    }

    @objc public func demonstrateError() {  // @exempt(from: tests) Requires user interaction.
      let error = TextConvertibleNumberParseError.invalidDigit("π", entireString: "3π")
      error.display()
    }

    @objc public func demonstrateImage() {
      let label = UserFacing<StrictString, InterfaceLocalization>({ localization in
        switch localization {
        case .englishCanada:
          return "Image"
        }
      })
      demonstrate(ImageView(image: Image.empty), windowTitle: label)
    }

    @objc public func demonstrateLabel() {
      let label = UserFacing<StrictString, InterfaceLocalization>({ localization in
        switch localization {
        case .englishCanada:
          return "Label"
        }
      })
      demonstrate(Label(text: .static(label)), windowTitle: label)
    }

    @objc public func demonstrateLabelledTextField() {
      let label = UserFacing<StrictString, InterfaceLocalization>({ localization in
        switch localization {
        case .englishCanada:
          return "Labelled Text Field"
        }
      })
      demonstrate(LabelledTextField(labelText: .static(label)), windowTitle: label)
    }

    @objc public func demonstrateRadioButtonSet() {
      let label = UserFacing<StrictString, InterfaceLocalization>({ localization in
        switch localization {
        case .englishCanada:
          return "Radio Button Set"
        }
      })
      enum Value: CaseIterable {
        case text
        case symbol
        var label: UserFacing<ButtonLabel, InterfaceLocalization> {
          switch self {
          case .text:
            return UserFacing<ButtonLabel, InterfaceLocalization>({ _ in
              return .text("Segment")
            })
          case .symbol:
            return UserFacing<ButtonLabel, InterfaceLocalization>({ _ in
              return .symbol(Image.empty)
            })
          }
        }
      }
      demonstrate(
        RadioButtonSet<Value, InterfaceLocalization>(labels: { $0.label }),
        windowTitle: label
      )
    }

    @objc public func demonstrateTextEditor() {
      demonstrate(
        TextEditor(),
        windowTitle: UserFacing<StrictString, InterfaceLocalization>({ localization in
          switch localization {
          case .englishCanada:
            return "Text Editor"
          }
        })
      )
    }

    @objc public func demonstrateTextField() {
      demonstrate(
        TextField(),
        windowTitle: UserFacing<StrictString, InterfaceLocalization>({ localization in
          switch localization {
          case .englishCanada:
            return "Text Field"
          }
        })
      )
    }

    #if canImport(AppKit)
      @objc public func demonstrateFullscreenWindow() {
        let window = Window<InterfaceLocalization>.fullscreenWindow(
          name: .static(
            UserFacing<StrictString, InterfaceLocalization>({ localization in
              switch localization {
              case .englishCanada:
                return "Fullscreen Window"
              }
            })
          ),
          view: CocoaView()
        )
        demonstrate(window)
      }
    #endif
  #endif

  // #workaround(Swift 5.2.2, Web doesn’t have Foundation yet.)
  #if !os(WASI)
    @objc private func doNothing() {  // @exempt(from: tests)
    }
  #endif
}
