/*
 ProcessInfo.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGLogic
import SDGText
import SDGLocalization
import SDGCalendar

import SDGInterfaceBasics

import SDGInterfaceLocalizations

extension ProcessInfo {

    /// Validates the application bundle.
    ///
    /// This method is intended for use in tests. It does nothing if SDGInterface was compiled in release mode.
    ///
    /// - Parameters:
    ///     - applicationBundle: The main application bundle.
    ///     - localizations: The localizations to validate.
    public static func validate<L>(applicationBundle: Bundle, localizations: L.Type) where L : InputLocalization { // @exempt(from: tests)
        #if VALIDATION
        var failing = false
        defer {
            SDGLocalization.assert(¬failing, UserFacing<StrictString, APILocalization>({ localization in
                switch localization {
                case .englishCanada:
                    return "The application bundle fails validation."
                }
            }))
        }

        func assert(_ condition: Bool, _ message: UserFacing<StrictString, APILocalization>) {
            if ¬condition {
                failing = true
                print(message)
            }
        }
        func assertExists<T>(_ a: (value: T?, key: String)) {
            assert(a.value ≠ nil, UserFacing<StrictString, APILocalization>({ localization in
                switch localization {
                case .englishCanada:
                    return "Information missing: \(a.key)"
                }
            }))
        }
        func assertEqual<T>(_ a: (value: T, key: String), _ b: (value: T, key: String)) where T : Equatable {
            assert(a.value == b.value, UserFacing<StrictString, APILocalization>({ localization in
                switch localization {
                case .englishCanada:
                    return "\(a.key) ≠ \(b.key); “\(arbitraryDescriptionOf: a.value)” ≠ “\(arbitraryDescriptionOf: b.value)”"
                }
            }))
        }

        let unlocalizedDictionary = applicationBundle.infoDictionary

        #if !os(Linux)
        var fallbackLocalizedInformation: NSDictionary?
        #endif
        for localization in localizations.allCases {
            #if !os(Linux)
            let infoPlist = applicationBundle.url(forResource: "InfoPlist", withExtension: "strings", subdirectory: nil, localization: localization.code)
            let dictionary: NSDictionary? = (infoPlist.flatMap({ (url: URL) -> NSDictionary? in
                return try? NSDictionary(contentsOf: url, error: ())
            }))
            let nameKey = "CFBundleDisplayName"
            let shortKey = "CFBundleName"
            let systemName: String? = dictionary?[nameKey] as? String
            let short: String? = dictionary?[shortKey] as? String

            let form = ApplicationNameForm._isolatedForm(for: localization.code)
            let name: String? = form.flatMap({ ProcessInfo.applicationName($0) }).flatMap({ String($0) })
            assertEqual(
                (systemName, localization.code + ".InfoPlist.strings." + nameKey),
                (name, "ProcessInfo.applicationName." + localization.code))
            if let count = name?.utf16.count,
                count < 16 {
                assertEqual(
                    (short, localization.code + ".InfoPlist.strings." + shortKey),
                    (name, "ProcessInfo.applicationName." + localization.code))
            } else if name == nil {
                assertEqual(
                    (short, localization.code + ".InfoPlist.strings." + shortKey),
                    (name, "ProcessInfo.applicationName." + localization.code))
            }

            let copyrightKey = "NSHumanReadableCopyright"
            let copyright = dictionary?[copyrightKey] as? String
            assertExists((copyright, localization.code + ".InfoPlist.strings." + copyrightKey))
            if let text = copyright {
                assert(
                    text.contains(String(CalendarDate.gregorianNow().gregorianYear.inEnglishDigits())),
                    UserFacing<StrictString, APILocalization>({ localization in
                        switch localization {
                        case .englishCanada:
                            return "Copyright out of date: \(localization.code + ".InfoPlist.strings." + copyrightKey)"
                        }
                    }))
            }

            let appleEventsKey = "NSAppleEventsUsageDescription"
            if unlocalizedDictionary?[appleEventsKey] ≠ nil {
                let appleEvents = dictionary?[appleEventsKey] as? String
                assertExists((appleEvents, localization.code + ".InfoPlist.strings." + appleEventsKey))
            }

            if localization.code == localizations.fallbackLocalization.code {
                fallbackLocalizedInformation = dictionary
            }
            #endif
        }

        let systemLocalizationsKey = "CFBundleAllowMixedLocalizations"
        assertExists((
            unlocalizedDictionary?[systemLocalizationsKey] as? Bool,
            "Info.plist" + systemLocalizationsKey))

        let hasLocalizedNameKey = "LSHasLocalizedDisplayName"
        assertExists((
            unlocalizedDictionary?[hasLocalizedNameKey] as? Bool,
            "Info.plist" + hasLocalizedNameKey))

        #if !os(Linux)
        for (key, value) in fallbackLocalizedInformation ?? [:] {
            if let stringKey = key as? String,
                let stringValue = value as? String {
                assertEqual(
                    (stringValue, "\(localizations.fallbackLocalization.code).InfoPlist.strings.\(stringKey)"),
                    (unlocalizedDictionary?[stringKey] as? String, "Info.plist.\(stringKey)"))
            }
        }
        #endif
        #endif
    }
}
