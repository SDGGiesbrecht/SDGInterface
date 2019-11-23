/*
 ProgressBar.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

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

  import SDGMathematics

  import SDGViews

  /// An image view.
  public final class ProgressBar: SpecificView {

    // MARK: - Initialization

    /// Creates an image view displaying an image.
    public init() {
      #if canImport(AppKit)
        specificNative = NSProgressIndicator()
      #elseif canImport(UIKit)
        specificNative = UIProgressView()
      #endif

      #if canImport(AppKit)
        specificNative.usesThreadedAnimation = true
      #endif

      progressValue = nil
    }

    // MARK: - Properties

    #if canImport(UIKit)
      private var minValue: Double = 0
      private var maxValue: Double = 1
      private var doubleValue: Double? = 0
      private func refreshNativeBar() {
        let progress: Float
        if let value = doubleValue {
          progress = Float((value − minValue) ÷ (maxValue − minValue))
        } else {
          progress = 0
        }
        specificNative.setProgress(progress, animated: true)
      }
    #endif

    /// The value indicated by the start of the progress bar.
    public var startValue: Double {
      get {
        #if canImport(AppKit)
          return specificNative.minValue
        #elseif canImport(UIKit)
          return minValue
        #endif
      }
      set {
        #if canImport(AppKit)
          specificNative.minValue = newValue
        #elseif canImport(UIKit)
          minValue = newValue
          refreshNativeBar()
        #endif
      }
    }

    /// The value indicated by the start of the progress bar.
    public var endValue: Double {
      get {
        #if canImport(AppKit)
          return specificNative.maxValue
        #elseif canImport(UIKit)
          return maxValue
        #endif
      }
      set {
        #if canImport(AppKit)
          specificNative.maxValue = newValue
        #elseif canImport(UIKit)
          maxValue = newValue
          refreshNativeBar()
        #endif
      }
    }

    /// The value indicated by the progress bar.
    ///
    /// `nil` represents an indeterminate value.
    public var progressValue: Double? {
      get {
        #if canImport(AppKit)
          return specificNative.isIndeterminate ? nil : specificNative.doubleValue
        #elseif canImport(UIKit)
          return doubleValue
        #endif
      }
      set {
        #if canImport(AppKit)
          if let value = newValue {
            specificNative.isIndeterminate = false
            specificNative.stopAnimation(nil)
            specificNative.doubleValue = value
          } else {
            specificNative.doubleValue = 0
            specificNative.isIndeterminate = true
            specificNative.startAnimation(nil)
          }
        #elseif canImport(UIKit)
          doubleValue = newValue
          refreshNativeBar()
        #endif
      }
    }

    // MARK: - SpecificView

    #if canImport(AppKit)
      public let specificNative: NSProgressIndicator
    #elseif canImport(UIKit)
      public let specificNative: UIProgressView
    #endif
  }
#endif
