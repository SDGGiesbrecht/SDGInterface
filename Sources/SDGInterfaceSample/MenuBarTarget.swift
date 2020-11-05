/*
 MenuBarTarget.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGControlFlow
import SDGLogic
import SDGText
import SDGLocalization

import SDGViews
import SDGTextDisplay
import SDGImageDisplay
import SDGButtons
import SDGWindows
import SDGErrorMessages

@objc public class MenuBarTarget: NSObject {

  internal static let shared = MenuBarTarget()

  #if (canImport(AppKit) || canImport(UIKit)) && !os(watchOS)
    private func demonstrate<Content, L>(_ window: Window<Content, L>) {
      window.display()
    }
    private func demonstrate<V, L>(_ view: V, windowTitle: UserFacing<StrictString, L>)
    where V: LegacyView {
      #if canImport(AppKit)
        let window = Window(type: .auxiliary(nil), name: windowTitle, content: view.padding())
        demonstrate(window)
      #else
        let window = Window(type: .primary(nil), name: windowTitle, content: view.padding().cocoa())
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
      demonstrate(Image.empty, windowTitle: label)
    }

    @objc public func demonstrateLabel() {
      let label = UserFacing<StrictString, InterfaceLocalization>({ localization in
        switch localization {
        case .englishCanada:
          return "Label"
        }
      })
      demonstrate(Label(label), windowTitle: label)
    }

    @objc public func demonstrateLabelledTextField() {
      let label = UserFacing<StrictString, InterfaceLocalization>({ localization in
        switch localization {
        case .englishCanada:
          return "Labelled Text Field"
        }
      })
      demonstrate(
        LabelledTextField(label: Label(label), field: TextField(contents: Shared(StrictString()))),
        windowTitle: label
      )
    }

    @objc public func demonstrateLog() {
      let label = UserFacing<StrictString, InterfaceLocalization>({ localization in
        switch localization {
        case .englishCanada:
          return "Log"
        }
      })
      let content = Shared(RichText())
      demonstrate(Log(contents: content), windowTitle: label)
      var entry = 0
      if #available(macOS 10.12, tvOS 10, iOS 10, *) {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
          entry += 1
          var entryText = entry.inDigits()
          if entry ≠ 1 {
            entryText.prepend("\n")
          }
          content.value.append(contentsOf: RichText(rawText: entryText))
          if entry == 100 {
            timer.invalidate()  // @exempt(from: tests)
          }
        }
      }
    }

    @objc public func demonstrateSegmentedControl() {
      enum Value: CaseIterable {
        case text
        case symbol
        fileprivate var label: UserFacing<ButtonLabel, InterfaceLocalization> {
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
      let label = UserFacing<StrictString, InterfaceLocalization>({ localization in
        switch localization {
        case .englishCanada:
          return "Segmented Control"
        }
      })
      let segmentedControl = SegmentedControl<Value, InterfaceLocalization>(
        labels: { $0.label },
        selection: Shared(.text)
      )
      #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
        if #available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *) {
          _ = segmentedControl.swiftUI().body  // Eager execution to simplify testing.
        }
      #endif
      demonstrate(
        segmentedControl,
        windowTitle: label
      )
    }

    #if !os(tvOS)
      @objc public func demonstrateTextEditor() {
        demonstrate(
          TextEditor(contents: Shared(RichText())),
          windowTitle: UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
              return "Text Editor"
            }
          })
        )
      }
    #endif

    @objc public func demonstrateTextField() {
      demonstrate(
        TextField(contents: Shared(StrictString())),
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
        let window = Window(
          type: .fullscreen,
          name: UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
              return "Fullscreen Window"
            }
          }),
          content: CocoaView()
        )
        demonstrate(window)
      }
    #endif
  #endif

  // #workaround(Swift 5.3, Web doesn’t have Foundation yet.)
  #if !os(WASI)
    @objc private func doNothing() {  // @exempt(from: tests)
    }
  #endif
}
