/*
 Application.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation
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
import SDGWindows
import SDGInterfaceElements
import SDGErrorMessages
import SDGMenuBar
import SDGApplication

extension Application {

    public static func setUp() {
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
    }

    #if !os(watchOS)
    public class func setUpAndMain() -> Never { // @exempt(from: tests)
        setUp()
        // @example(main)
        Application.main(mediator: SystemMediator())
        // @endExample
    }
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
        #warning("Remove.")
        editor.nativeTextView.text = "\n\n\n\n\n\n\n\u{A2}\u{B2}\u{C2}"
        let window = Window.primaryWindow(name: .static(ApplicationNameForm.localizedIsolatedForm), view: editor)
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] == nil { // #exempt(from: tests)
            // This call fails during tests.
            window.display()
        }
        #endif
    }

    #if (canImport(AppKit) || canImport(UIKit)) && !os(watchOS)
    private func demonstrate(_ window: AnyWindow) {
        window.display()
    }
    private func demonstrate<L>(_ view: NativeView, windowTitle: UserFacing<StrictString, L>) {
        #if canImport(AppKit)
        let window = Window<L>.auxiliaryWindow(name: .static(windowTitle), view: MarginView(contents: view))
        demonstrate(window)
        #else
        let window = Window(name: .static(windowTitle), view: MarginView(contents: view))
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
        demonstrate(Button(label: Shared(label)), windowTitle: label)
    }

    @objc public func demonstrateButtonSet() {
        let label = UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "ButtonSet"
            }
        })
        let firstLabel: Shared<UserFacing<ButtonSetSegmentLabel, InterfaceLocalization>>
            = Shared(UserFacing({ _ in .text("Segment") }))
        let secondLabel: Shared<UserFacing<ButtonSetSegmentLabel, InterfaceLocalization>>
            = Shared(UserFacing({ _ in .image(Image.empty) }))
        demonstrate(ButtonSet<InterfaceLocalization>(segments: [
            (label: firstLabel, action: #selector(Application.doNothing), target: self),
            (label: secondLabel, action: #selector(Application.doNothing), target: self)
            ]), windowTitle: label)
    }

    @objc public func demonstrateCheckBox() {
        #if canImport(AppKit)
        let label = UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Check Box"
            }
        })
        demonstrate(CheckBox(label: Shared(label)), windowTitle: label)
        #endif
    }

    @objc public func demonstrateError() { // @exempt(from: tests) Requires user interaction.
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
        demonstrate(ImageView(image: Image.empty).native, windowTitle: label)
    }

    @objc public func demonstrateLabel() {
        let label = UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Label"
            }
        })
        demonstrate(Label(text: .static(label)).native, windowTitle: label)
    }

    @objc public func demonstrateLabelledTextField() {
        let label = UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Labelled Text Field"
            }
        })
        demonstrate(LabelledTextField(labelText: .static(label)).native, windowTitle: label)
    }

    @objc public func demonstrateLetterbox() {
        let label = UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Letterbox"
            }
        })
        demonstrate(Letterbox(content: TextEditor().native, aspectRatio: 1), windowTitle: label)
    }

    @objc public func demonstrateTextEditor() {
        demonstrate(TextEditor().native, windowTitle: UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Text Editor"
            }
        }))
    }

    @objc public func demonstrateTextField() {
        demonstrate(TextField().native, windowTitle: UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Text Field"
            }
        }))
    }

    #if canImport(AppKit)
    @objc public func demonstrateFullscreenWindow() {
        let window = Window<InterfaceLocalization>.fullscreenWindow(name: .static(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Fullscreen Window"
            }
        })), view: NativeView())
        demonstrate(window)
    }
    #endif
    #endif

    @objc private func doNothing() { // @exempt(from: tests)
    }
}
