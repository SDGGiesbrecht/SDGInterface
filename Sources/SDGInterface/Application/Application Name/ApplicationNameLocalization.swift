/*
 ApplicationNameLocalization.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2023 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGText
import SDGLocalization

/// A dynamic localization set based on the provided forms of the application’s name.
///
/// See `ProcessInfo.applicationName`.
public struct ApplicationNameLocalization: Localization {

  private init(undefined: Void) {
    self.code = "und"
  }

  private var _correspondingIsolatedName: StrictString?
  internal var correspondingIsolatedName: StrictString {
    if let defined = _correspondingIsolatedName {
      return defined
    } else {
      #if PLATFORM_LACKS_FOUNDATION_PROCESS_INFO
        return ""
      #else
        // This fallback is only for “und”.
        let information = Bundle.main.infoDictionary
        if let name = information?["CFBundleDisplayName" as String] as? String
          ?? information?["CFBundleName" as String] as? String
        {
          return StrictString(name)  // @exempt(from: tests)
        }
        return StrictString(ProcessInfo.processInfo.processName)  // @exempt(from: tests)
      #endif
    }
  }

  // MARK: - Localization

  public init?(exactly code: String) {
    #if PLATFORM_LACKS_FOUNDATION_PROCESS_INFO
      return nil
    #else
      guard let form = ApplicationNameForm.isolatedForm(for: code),
        let name = ProcessInfo.applicationName(form)
      else {
        return nil
      }
      self.code = code
      _correspondingIsolatedName = name
    #endif
  }

  public var code: String

  public static var fallbackLocalization: ApplicationNameLocalization = ApplicationNameLocalization(
    undefined: ()
  )
}
