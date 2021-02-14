/*
 ProgressBar.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) || (canImport(AppKit) || canImport(UIKit)) && !os(watchOS)
  #if canImport(SwiftUI)
    import SwiftUI
  #endif
  #if canImport(AppKit)
    import AppKit
  #endif
  #if canImport(UIKit)
    import UIKit
  #endif

  import SDGControlFlow
  import SDGLogic
  import SDGMathematics

  import SDGInterface

  /// A progress bar.
  @available(watchOS 7, *)
  public struct ProgressBar: LegacyView {

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

    internal static func zeroToOneRepresentation(of value: Double, in range: ClosedRange<Double>)
      -> Double
    {
      return (value − range.lowerBound) ÷ (range.upperBound − range.lowerBound)
    }

    // MARK: - LegacyView

    #if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
      public func cocoa() -> CocoaView {
        return useSwiftUI2OrFallback(to: {
          return CocoaView(CocoaImplementation(range: range, value: value))
        })
      }
    #endif
  }

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 7, *)
  extension ProgressBar: View {

    // MARK: - View

    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      public func swiftUI() -> some SwiftUI.View {
        #if os(watchOS)
          return SwiftUI.AnyView(SwiftUIImplementation(range: range, value: value))
        #else
          if #available(macOS 11, tvOS 14, iOS 14, *), ¬legacyMode {
            let swiftUI = SwiftUIImplementation(range: range, value: value)
            #if DEBUG
              _ = swiftUI.body  // Eager execution to simplify testing.
            #endif
            return SwiftUI.AnyView(swiftUI)
          } else {
            return SwiftUI.AnyView(cocoa().swiftUI())
          }
        #endif  // @exempt(from: tests)
      }
    #endif
  }
#endif
