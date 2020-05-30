/*
 LocalizationSetting.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLocalization

extension LocalizationSetting {

  #warning("Will this be needed if it can be sunk into SDGCornerstone?")
  @available(macOS 10.15, *)
  public static let _observableCurrent: _Observable<LocalizationSetting> = _Observable(
    LocalizationSetting.current
  )
}
