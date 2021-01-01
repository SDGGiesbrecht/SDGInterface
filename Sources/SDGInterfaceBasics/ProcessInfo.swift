/*
 ProcessInfo.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.3.1, Web lacks ProcessInfo.)
#if !os(WASI)
  import Foundation

  import SDGText
  import SDGLocalization

  import SDGInterfaceLocalizations

  extension ProcessInfo {

    /// A closure which resolves the application name for a particular localized grammatical form.
    ///
    /// This is a typealias for `(_ form: ApplicationNameForm) -> StrictString?`.
    public typealias ApplicationNameResolver = (_ form: ApplicationNameForm) -> StrictString?

    private static var _applicationName: ApplicationNameResolver?
    /// A closure which produces the declined application name suitable for use in various gramatical contexts.
    ///
    /// Applications must assign this property a value at the very beginning of program execution. Failing to do so before the first attempt to read this property will trigger a precondition failure.
    public static var applicationName: ApplicationNameResolver {
      get {
        guard let result = _applicationName else {
          preconditionFailure(
            UserFacing<StrictString, APILocalization>({ localization in
              switch localization {
              case .englishCanada:  // @exempt(from: tests)
                return
                  "“ProcessInfo.applicationName” has not been set yet. (Import Foundation, SDGText and SDGInterfaceBasics.)"
              }
            })
          )
        }
        return result
      }
      set {
        _applicationName = newValue
      }
    }
  }
#endif
