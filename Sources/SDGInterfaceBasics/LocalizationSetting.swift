/*
 LocalizationSetting.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(Combine)
  import SDGLocalization

  extension LocalizationSetting {

    // #workaround(SDGCornerstone 5.0.0, Belongs in SDGCornerstone.)
    @available(macOS 10.15, tvOS 13, *)
    public static let _observableCurrent: _Observable<LocalizationSetting> = _Observable(
      LocalizationSetting.current
    )
  }
#endif
