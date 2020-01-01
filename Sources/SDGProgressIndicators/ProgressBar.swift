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

  import SDGMathematics

  import SDGViews

  /// An image view.
  public final class ProgressBar: CocoaViewImplementation, SpecificView {

    // MARK: - Initialization

    /// Creates an image view displaying an image.
    public init() {
      #if canImport(AppKit)
        specificCocoaView = NSProgressIndicator()
      #elseif canImport(UIKit)
        specificCocoaView = UIProgressView()
      #endif

      #if canImport(AppKit)
        specificCocoaView.usesThreadedAnimation = true
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
        specificCocoaView.setProgress(progress, animated: true)
      }
    #endif

    /// The value indicated by the start of the progress bar.
    public var startValue: Double {
      get {
        #if canImport(AppKit)
          return specificCocoaView.minValue
        #elseif canImport(UIKit)
          return minValue
        #endif
      }
      set {
        #if canImport(AppKit)
          specificCocoaView.minValue = newValue
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
          return specificCocoaView.maxValue
        #elseif canImport(UIKit)
          return maxValue
        #endif
      }
      set {
        #if canImport(AppKit)
          specificCocoaView.maxValue = newValue
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
          return specificCocoaView.isIndeterminate ? nil : specificCocoaView.doubleValue
        #elseif canImport(UIKit)
          return doubleValue
        #endif
      }
      set {
        #if canImport(AppKit)
          if let value = newValue {
            specificCocoaView.isIndeterminate = false
            specificCocoaView.stopAnimation(nil)
            specificCocoaView.doubleValue = value
          } else {
            specificCocoaView.doubleValue = 0
            specificCocoaView.isIndeterminate = true
            specificCocoaView.startAnimation(nil)
          }
        #elseif canImport(UIKit)
          doubleValue = newValue
          refreshNativeBar()
        #endif
      }
    }

    // MARK: - SpecificView

    #if canImport(AppKit)
      public let specificCocoaView: NSProgressIndicator
    #elseif canImport(UIKit)
      public let specificCocoaView: UIProgressView
    #endif
  }
#endif
