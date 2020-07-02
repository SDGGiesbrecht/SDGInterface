/*
 ProgressBar.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if (canImport(AppKit) || canImport(UIKit)) && !os(watchOS)
  #if canImport(AppKit)
    import AppKit
  #endif
  #if canImport(UIKit)
    import UIKit
  #endif

  import SDGControlFlow

  import SDGViews

  /// A progress bar.
  public struct ProgressBar: CocoaViewImplementation, View {

    // MARK: - Initialization

    /// Creates a progress bar.
    ///
    /// - Parameters:
    ///   - range: The range of the progress bar.
    ///   - value: The current value of the progress bar. (`nil` indicates an indeterminate value.)
    public init(
      range: Shared<ClosedRange<Double>>,
      value: Shared<Double?>
    ) {
      self.range = range
      self.value = value
    }

    // MARK: - Properties

    private let range: Shared<ClosedRange<Double>>
    private let value: Shared<Double?>

    // MARK: - LegacyView

    public func cocoa() -> CocoaView {
      return CocoaView(CocoaImplementation(range: range, value: value))
    }
  }
#endif
