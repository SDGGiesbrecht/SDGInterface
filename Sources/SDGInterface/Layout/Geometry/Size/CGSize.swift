/*
 CGSize.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2024 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(CoreGraphics)
  import CoreGraphics

  extension CGSize {

    /// Creates a CoreGraphics size from a size.
    ///
    /// - Parameters:
    ///   - size: The size.
    public init(_ size: SDGInterface.Size) {
      self.init(width: CGFloat(size.width), height: CGFloat(size.height))
    }
  }
#endif
