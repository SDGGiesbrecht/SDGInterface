/*
 AttachmentAnchor.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGInterfaceBasics

/// A shimmed version of `SwiftUI.PopoverAttachmentAnchor` with no availability constraints.
public enum AttachmentAnchor {

  /// A shimmed version of `SwiftUI.PopoverAttachmentAnchor.point` with no availability constraints.
  case point(Point)

  /// A shimmed version of `SwiftUI.PopoverAttachmentAnchor.rect` with no availability constraints.
  case rectangle(RectangularAttachmentAnchor)
}
