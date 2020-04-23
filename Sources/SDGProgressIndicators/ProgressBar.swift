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
  public final class ProgressBar: CocoaViewImplementation, View {

    // MARK: - Initialization

    /// Creates an image view displaying an image.
    public init() {
      #if canImport(AppKit)
        cocoaView = NSProgressIndicator()
      #elseif canImport(UIKit)
        cocoaView = UIProgressView()
      #endif

      #if canImport(AppKit)
        cocoaView.usesThreadedAnimation = true
      #endif

      progressValue = nil
    }

    // MARK: - Properties

    #if canImport(AppKit)
      private let cocoaView: NSProgressIndicator
    #elseif canImport(UIKit)
      private let cocoaView: UIProgressView
    #endif

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
        cocoaView.setProgress(progress, animated: true)
      }
    #endif

    /// The value indicated by the start of the progress bar.
    public var startValue: Double {
      get {
        #if canImport(AppKit)
          return cocoaView.minValue
        #elseif canImport(UIKit)
          return minValue
        #endif
      }
      set {
        #if canImport(AppKit)
          cocoaView.minValue = newValue
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
          return cocoaView.maxValue
        #elseif canImport(UIKit)
          return maxValue
        #endif
      }
      set {
        #if canImport(AppKit)
          cocoaView.maxValue = newValue
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
          return cocoaView.isIndeterminate ? nil : cocoaView.doubleValue
        #elseif canImport(UIKit)
          return doubleValue
        #endif
      }
      set {
        #if canImport(AppKit)
          if let value = newValue {
            cocoaView.isIndeterminate = false
            cocoaView.stopAnimation(nil)
            cocoaView.doubleValue = value
          } else {
            cocoaView.doubleValue = 0
            cocoaView.isIndeterminate = true
            cocoaView.startAnimation(nil)
          }
        #elseif canImport(UIKit)
          doubleValue = newValue
          refreshNativeBar()
        #endif
      }
    }

    // MARK: - LegacyView

    public func cocoa() -> CocoaView {
      return CocoaView(cocoaView)
    }
  }
#endif
