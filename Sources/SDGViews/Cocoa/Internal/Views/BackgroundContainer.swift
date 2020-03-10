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

  internal struct BackgroundContainer<Foreground, Background>: CocoaViewImplementation
  where Foreground: LegacyView, Background: LegacyView {

    // MARK: - Initialization

    internal init(
      background: Background,
      foreground: Foreground,
      alignment: SDGInterfaceBasics.Alignment
    ) {
      self.container = AnyCocoaView()
      self.background = background.stabilize()
      self.foreground = foreground.stabilize()

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

      container.cocoa().native.translatesAutoresizingMaskIntoConstraints = false
      container.fill(with: self.foreground, margin: .specific(0))

      preferEqual(.width)
      preferEqual(.height)
    }

    private func makeEqual(_ attribute: NSLayoutConstraint.Attribute) {
      container.addSubviewIfNecessary(background)
      container.cocoa().native.addConstraint(
        NSLayoutConstraint(
          item: container.cocoa().native,
          attribute: attribute,
          relatedBy: .equal,
          toItem: background.cocoaView,
          attribute: attribute,
          multiplier: 1,
          constant: 0
        )
      )
    }

    private func preferEqual(_ attribute: NSLayoutConstraint.Attribute) {
      let constraint = NSLayoutConstraint(
        item: background.cocoaView,
        attribute: attribute,
        relatedBy: .equal,
        toItem: container .. cocoa().native,
        attribute: attribute,
        multiplier: 1,
        constant: 0
      )
      constraint.priority = FrameContainer<Foreground>.fillingPriority
      container.cocoaView.addConstraint(constraint)
    }

    // MARK: - Properties

    private let container: AnyCocoaView
    private let background: Stabilized<Background>
    private let foreground: Stabilized<Foreground>

    // MARK: - View

    public func cocoa() -> CocoaView {
      return container.cocoa()
    }
  }
#endif
