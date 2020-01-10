/*
 BackgroundContainer.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
  #if canImport(AppKit)
    import AppKit
  #elseif canImport(UIKit) && !os(watchOS)
    import UIKit
  #endif

  import SDGInterfaceBasics

  internal struct BackgroundContainer: CocoaViewImplementation {

    // MARK: - Initialization

    internal init(background: View, foreground: View, alignment: SDGInterfaceBasics.Alignment) {
      self.container = AnyCocoaView()
      self.background = StabilizedView(background)
      self.foreground = StabilizedView(foreground)

      switch alignment.horizontal {
      case .leading:
        makeEqual(.leading)
      case .centre:
        makeEqual(.centerX)
      case .trailing:
        makeEqual(.trailing)
      }
      switch alignment.vertical {
      case .top:
        makeEqual(.top)
      case .centre:
        makeEqual(.centerY)
      case .bottom:
        makeEqual(.bottom)
      }

      container.fill(with: self.foreground)
    }

    private func makeEqual(_ attribute: NSLayoutConstraint.Attribute) {
      container.addSubviewIfNecessary(background)
      container.cocoaView.addConstraint(
        NSLayoutConstraint(
          item: container.cocoaView,
          attribute: attribute,
          relatedBy: .equal,
          toItem: background.cocoaView,
          attribute: attribute,
          multiplier: 1,
          constant: 0
        )
      )
    }

    // MARK: - Properties

    private let container: AnyCocoaView
    private let background: StabilizedView
    private let foreground: StabilizedView

    // MARK: - View

    #if canImport(AppKit)
      public var cocoaView: NSView {
        return container.cocoaView
      }
    #elseif canImport(UIKit) && !os(watchOS)
      public var cocoaView: UIView {
        return container.cocoaView
      }
    #endif
  }
#endif
