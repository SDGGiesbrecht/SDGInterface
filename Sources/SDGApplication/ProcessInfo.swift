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

        var fallbackLocalizedInformation: NSDictionary!
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
            #endif

            if localization.code == localizations.fallbackLocalization.code {
                fallbackLocalizedInformation = dictionary
            }
        }

        let dictionary = applicationBundle.infoDictionary

        let systemLocalizationsKey = "CFBundleAllowMixedLocalizations"
        assertExists((
            dictionary?[systemLocalizationsKey] as? Bool,
            "Info.plist" + systemLocalizationsKey))

        let hasLocalizedNameKey = "LSHasLocalizedDisplayName"
        assertExists((
            dictionary?[hasLocalizedNameKey] as? Bool,
            "Info.plist" + hasLocalizedNameKey))

        for (key, value) in fallbackLocalizedInformation {
            if let stringKey = key as? String,
                let stringValue = value as? String {
                assertEqual(
                    (stringValue, "\(localizations.fallbackLocalization.code).InfoPlist.strings.\(stringKey)"),
                    (dictionary?[stringKey] as? String, "Info.plist.\(stringKey)"))
            }
        }
        #endif
    }
}
