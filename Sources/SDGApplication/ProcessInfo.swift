/*
 ProcessInfo.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

import SDGInterfaceLocalizations

extension ProcessInfo {

    /// A closure of type `(_ form: ApplicationNameForm) -> StrictString?` which resolves the application name for a particular localized grammatical form.
    public typealias ApplicationNameResolver = (_ form: ApplicationNameForm) -> StrictString?

    private static var _applicationName: ApplicationNameResolver?
    /// A closure which produces the declined application name suitable for use in various gramatical contexts.
    ///
    /// Applications must assign this property a value at the very beginning of program execution. Failing to do so before the first attempt to read this property will trigger a precondition failure.
    public static var applicationName: ApplicationNameResolver {
        get {
            guard let result = _applicationName else {
                preconditionFailure(UserFacing<StrictString, APILocalization>({ localization in
                    switch localization {
                    case .englishCanada: // @exempt(from: tests)
                        return "“ProcessInfo.applicationName” has not been set yet. (Import SDGInterface or SDGApplication.)"
                    }
                }))
            }
            return result
        }
        set {
            _applicationName = newValue
        }
    }

    /// Validates the application bundle.
    ///
    /// This method is intended for use in tests. It does nothing if SDGInterface was compiled in release mode.
    ///
    /// - Parameters:
    ///     - applicationBundle: The main application bundle.
    public static func validate(applicationBundle: Bundle) { // @exempt(from: tests)
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
            func assertEqual<T>(_ a: (value: T, key: String), _ b: (value: T, key: String)) where T : Equatable {
                assert(a.value == b.value, UserFacing<StrictString, APILocalization>({ localization in
                    switch localization {
                    case .englishCanada:
                        return StrictString("\(a.key) ≠ \(b.key); “\(a.value)” ≠ “\(b.value)”")
                    }
                }))
            }

            for localization in MenuBarLocalization.allCases {
                let infoPlist = applicationBundle.url(forResource: "InfoPlist", withExtension: "strings", subdirectory: nil, localization: localization.code)
                let dictionary: NSDictionary? = (infoPlist.flatMap({ (url: URL) -> NSDictionary? in
                    return try? NSDictionary(contentsOf: url, error: ())
                }))
                let nameKey = "CFBundleDisplayName"
                let shortKey = "CFBundleName"
                let systemName: String? = dictionary?[nameKey] as? String
                let short: String? = dictionary?[shortKey] as? String

                let form = ApplicationNameForm.isolatedForm(for: localization.code)
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
            }
        #endif
    }
}
