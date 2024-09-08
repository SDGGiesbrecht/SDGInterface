/*
 ProgressBar.CocoaImplementation.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2024 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if PLATFORM_HAS_COCOA_INTERFACE
  #if canImport(AppKit)
    import AppKit
  #endif
  #if canImport(UIKit)
    import UIKit
  #endif

  import SDGControlFlow
  import SDGMathematics

  import SDGInterface

  extension ProgressBar {

    #if canImport(AppKit)
      internal typealias Superclass = NSProgressIndicator
    #else
      internal typealias Superclass = UIProgressView
    #endif
    internal class CocoaImplementation: Superclass, SharedValueObserver {

      // MARK: - Initialization

      public init(
        range: Shared<ClosedRange<Double>>,
        value: Shared<Double?>
      ) {
        self.range = range
        defer { range.register(observer: self) }
        self.value = value
        defer { range.register(observer: self) }

        super.init(frame: .zero)

        #if canImport(AppKit)
          usesThreadedAnimation = true
        #endif
      }

      internal required init?(coder: NSCoder) {  // @exempt(from: tests)
        return nil
      }

      // MARK: - Properties

      private let range: Shared<ClosedRange<Double>>
      private let value: Shared<Double?>

      // MARK: - SharedValueObserver

      internal func valueChanged(for identifier: String) {
        #if canImport(AppKit)
          let range = self.range.value
          minValue = range.lowerBound
          maxValue = range.upperBound
          if let value = value.value {
            isIndeterminate = false
            stopAnimation(nil)
            doubleValue = value
          } else {
            doubleValue = 0
            isIndeterminate = true
            startAnimation(nil)
          }
        #else
          let progress: Float
          if let value = value.value {
            progress = Float(ProgressBar.zeroToOneRepresentation(of: value, in: range.value))
          } else {
            progress = 0
          }
          setProgress(progress, animated: true)
        #endif
      }
    }
  }

#endif
