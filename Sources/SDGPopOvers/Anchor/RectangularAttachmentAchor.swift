/*
 RectangularAttachmentAchor.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGInterfaceBasics

/// A shimmed version of `SwiftUI.Anchor.Source` with no availability constraints.
public enum RectangularAttachmentAnchor {

  /// A shimmed version of `SwiftUI.Anchor.Source.bounds` with no availability constraints.
  case bounds

  /// A shimmed version of `SwiftUI.Anchor.Source.rect` with no availability constraints.
  case rectangle(Rectangle)
}
