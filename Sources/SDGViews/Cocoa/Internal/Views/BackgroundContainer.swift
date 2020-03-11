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
      self.container = CocoaView()
      self.background = background.cocoa()
      self.foreground = foreground.cocoa()

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
      container.fill(with: self.foreground, margin: 0)

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
          toItem: background.cocoa().native,
          attribute: attribute,
          multiplier: 1,
          constant: 0
        )
      )
    }

    private func preferEqual(_ attribute: NSLayoutConstraint.Attribute) {
      let constraint = NSLayoutConstraint(
        item: background.cocoa().native,
        attribute: attribute,
        relatedBy: .equal,
        toItem: container.cocoa().native,
        attribute: attribute,
        multiplier: 1,
        constant: 0
      )
      constraint.priority = FrameContainer<Foreground>.fillingPriority
      container.cocoa().native.addConstraint(constraint)
    }

    // MARK: - Properties

    private let container: CocoaView
    private let background: CocoaView
    private let foreground: CocoaView

    // MARK: - View

    public func cocoa() -> CocoaView {
      return container.cocoa()
    }
  }
#endif
