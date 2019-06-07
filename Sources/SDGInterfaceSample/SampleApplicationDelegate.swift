/*
 SampleApplicationDelegate.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics
import SDGLocalization

#if !os(watchOS)

#warning("Verify examples.")
// @example(sample)
public final class SampleApplicationDelegate {}
// @endExample

extension SampleApplicationDelegate {

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

    public class func setUpAndMain() { // @exempt(from: tests)
        setUp()
        Application.main(mediator: SystemMediator())
    }

    private func demonstrate(_ window: NSWindow) {
        window.makeKeyAndOrderFront(nil)
    }
    private func demonstrate<L>(_ view: View, windowTitle: UserFacing<StrictString, L>) {
        #if canImport(AppKit)
        let window = AuxiliaryWindow(title: Shared(windowTitle))
        window.contentView?.fill(with: view)
        demonstrate(window)
        #else
        let window = Window(title: Shared(windowTitle))
        let frame = UIViewController()
        window.rootViewController = frame
        frame.view.fill(with: view)
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
            = Shared(UserFacing({ _ in .image(Image()) }))
        demonstrate(ButtonSet<InterfaceLocalization>(segments: [
            (label: firstLabel, action: #selector(SampleApplicationDelegate.doNothing), target: self),
            (label: secondLabel, action: #selector(SampleApplicationDelegate.doNothing), target: self)
            ]), windowTitle: label)
    }

    #if canImport(AppKit)
    @objc public func demonstrateCheckBox() {
        let label = UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Check Box"
            }
        })
        demonstrate(CheckBox(label: Shared(label)), windowTitle: label)
    }
    #endif

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
        demonstrate(ImageView(), windowTitle: label)
    }

    @objc public func demonstrateLabel() {
        let label = UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Label"
            }
        })
        demonstrate(Label(text: Shared(label)), windowTitle: label)
    }

    @objc public func demonstrateLabelledTextField() {
        let label = UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Labelled Text Field"
            }
        })
        demonstrate(LabelledTextField(labelText: label), windowTitle: label)
    }

    @objc public func demonstrateLetterbox() {
        let label = UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Letterbox"
            }
        })
        demonstrate(Letterbox(content: TextEditor(), aspectRatio: 1), windowTitle: label)
    }

    @objc public func demonstrateTextEditor() {
        demonstrate(TextEditor(), windowTitle: UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Text Editor"
            }
        }))
    }

    @objc public func demonstrateTextField() {
        demonstrate(TextField(), windowTitle: UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Text Field"
            }
        }))
    }

    @objc public func demonstrateFullscreenWindow() {
        let window = FullscreenWindow(title: Shared(UserFacing<StrictString, InterfaceLocalization>({ localization in
            switch localization {
            case .englishCanada:
                return "Fullscreen Window"
            }
        })))
        demonstrate(window)
    }

    @objc private func doNothing() { // @exempt(from: tests)
    }
}

#endif
