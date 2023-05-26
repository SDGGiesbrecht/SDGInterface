/*
 LegacyView + Alert.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2021–2023 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

extension LegacyView {

  /// Returns a view with an associated alert.
  ///
  /// - Parameters:
  ///   - isPresented: A binding that toggles the presentation of the alert.
  ///   - alert: The alert.
  public func alert<L, M, N>(isPresented: Shared<Bool>, alert: Alert<L, M, N>) -> ViewWithAlert<
    Self, L, M, N
  > {
    return ViewWithAlert(view: self, alert: alert, isPresented: isPresented)
  }
}
