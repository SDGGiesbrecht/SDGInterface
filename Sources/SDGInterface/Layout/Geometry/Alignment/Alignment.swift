/*
 Alignment.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2022 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI)
  import SwiftUI
#endif

#if canImport(SwiftUI)
  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  extension SwiftUI.Alignment {

    /// Unwraps an instance of a shimmed `SDGInterface.Alignment`.
    ///
    /// - Parameters:
    ///   - shimmed: The shimmed instance.
    public init(_ shimmed: SDGInterface.Alignment) {
      self.init(
        horizontal: SwiftUI.HorizontalAlignment(shimmed.horizontal),
        vertical: SwiftUI.VerticalAlignment(shimmed.vertical)
      )
    }
  }
#endif

/// A shimmed version of `SwiftUI.Alignment` with no availability constraints.
public struct Alignment: Equatable {

  // MARK: - Static Properties

  /// A shimmed version of `SwiftUI.VerticalAlignment.topLeading` with no availability constraints.
  public static let topLeading: Alignment = Alignment(horizontal: .leading, vertical: .top)
  /// A shimmed version of `SwiftUI.VerticalAlignment.top` with no availability constraints.
  public static let top: Alignment = Alignment(horizontal: .centre, vertical: .top)
  /// A shimmed version of `SwiftUI.VerticalAlignment.topTrailing` with no availability constraints.
  public static let topTrailing: Alignment = Alignment(horizontal: .trailing, vertical: .top)
  /// A shimmed version of `SwiftUI.VerticalAlignment.leading` with no availability constraints.
  public static let leading: Alignment = Alignment(horizontal: .leading, vertical: .centre)
  /// A shimmed version of `SwiftUI.VerticalAlignment.center` with no availability constraints.
  public static let centre: Alignment = Alignment(horizontal: .centre, vertical: .centre)
  /// A shimmed version of `SwiftUI.VerticalAlignment.trailing` with no availability constraints.
  public static let trailing: Alignment = Alignment(horizontal: .trailing, vertical: .centre)
  /// A shimmed version of `SwiftUI.VerticalAlignment.bottomLeading` with no availability constraints.
  public static let bottomLeading: Alignment = Alignment(horizontal: .leading, vertical: .bottom)
  /// A shimmed version of `SwiftUI.VerticalAlignment.bottom` with no availability constraints.
  public static let bottom: Alignment = Alignment(horizontal: .centre, vertical: .bottom)
  /// A shimmed version of `SwiftUI.VerticalAlignment.bottomTrailing` with no availability constraints.
  public static let bottomTrailing: Alignment = Alignment(horizontal: .trailing, vertical: .bottom)

  // MARK: - Initializers

  /// A shimmed version of `SwiftUI.VerticalAlignment.horizontal` with no availability constraints.
  ///
  /// - Parameters:
  ///   - horizontal: The horizontal alignment.
  ///   - vertical: The vertical alignment.
  public init(horizontal: HorizontalAlignment, vertical: VerticalAlignment) {
    self.horizontal = horizontal
    self.vertical = vertical
  }

  // MARK: - Properties

  /// A shimmed version of `SwiftUI.VerticalAlignment.horizontal` with no availability constraints.
  public var horizontal: HorizontalAlignment
  /// A shimmed version of `SwiftUI.VerticalAlignment.vertical` with no availability constraints.
  public var vertical: VerticalAlignment

  // MARK: - Initialization

  #if canImport(SwiftUI)
    /// Wraps an instance of a standard `SwiftUI.ContentMode`.
    ///
    /// - Parameters:
    ///   - standard: The standard instance.
    @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
    public init?(_ standard: SwiftUI.Alignment) {
      guard let horizontal = HorizontalAlignment(standard.horizontal),
        let vertical = VerticalAlignment(standard.vertical)
      else {  // @exempt(from: tests) Not sure how to create such an alignment.
        // @exempt(from: tests)
        return nil
      }
      self.init(horizontal: horizontal, vertical: vertical)
    }
  #endif
}
