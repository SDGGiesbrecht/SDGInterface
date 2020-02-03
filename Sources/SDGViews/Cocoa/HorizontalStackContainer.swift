/*
 HorizontalStackContainer.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if (canImport(AppKit) || canImport(UIKit)) && !os(watchOS)
  #if canImport(AppKit)
    import AppKit
  #elseif canImport(UIKit)
    import UIKit
  #endif

  @available(iOS 9, *)  // @exempt(from: unicode)
  internal final class HorizontalStackContainer: CocoaViewImplementation, SpecificView {

    // MARK: - Initialization

    internal init(views: [View], spacing: Spacing = .automatic) {
      #if canImport(AppKit)
        specificCocoaView = NSStackView()
      #elseif canImport(UIKit)
        specificCocoaView = UIStackView()
      #endif

      self.views = views
      defer {
        viewsDidSet()
      }

      switch spacing {
      case .automatic:
        break
      case .specific(let measurement):
        specificCocoaView.spacing = CGFloat(measurement)
      }

      #if canImport(AppKit)
        specificCocoaView.setHuggingPriority(.required, for: .vertical)
      #endif
      specificCocoaView.alignment = .lastBaseline
    }

    // MARK: - Properties

    /// The arranged views.
    internal var views: [View] {
      didSet {
        viewsDidSet()
      }
    }
    private func viewsDidSet() {
      #if canImport(AppKit)
        while let view = specificCocoaView.views.first {
          specificCocoaView.removeView(view)
        }
        for view in views {
          specificCocoaView.addView(view.cocoaView, in: .trailing)
        }
      #elseif canImport(UIKit)
        while let view = specificCocoaView.arrangedSubviews.first {
          specificCocoaView.removeArrangedSubview(view)
        }
        for view in views {
          specificCocoaView.addArrangedSubview(view.cocoaView)
        }
      #endif
    }

    #if canImport(AppKit)
      internal let specificCocoaView: NSStackView
    #elseif canImport(UIKit)
      internal let specificCocoaView: UIStackView
    #endif
  }
#endif
