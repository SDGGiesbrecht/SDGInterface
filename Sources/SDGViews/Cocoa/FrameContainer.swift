/*
 FrameContainer.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

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

  import SDGLogic

  import SDGInterfaceBasics

  internal struct FrameContainer: CocoaViewImplementation {

    // MARK: - Initialization

    internal init(
      contents: View,
      minWidth: Double?,
      idealWidth: Double?,
      maxWidth: Double?,
      minHeight: Double?,
      idealHeight: Double?,
      maxHeight: Double?,
      alignment: SDGInterfaceBasics.Alignment
    ) {
      self.contents = StabilizedView(contents)
      self.container = AnyCocoaView()

      make(.width, .greaterThanOrEqual, to: minWidth)
      prefer(.width, of: idealWidth)
      make(.width, .lessThanOrEqual, to: maxWidth)
      make(.height, .greaterThanOrEqual, to: minHeight)
      prefer(.height, of: idealHeight)
      make(.height, .lessThanOrEqual, to: maxHeight)

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
    }

    private func make(
      _ attribute: NSLayoutConstraint.Attribute,
      _ relation: NSLayoutConstraint.Relation,
      to constant: Double?
    ) {
      if let constant = constant,
        constant ≠ .infinity
      {
        container.cocoaView.addConstraint(
          NSLayoutConstraint(
            item: container.cocoaView,
            attribute: attribute,
            relatedBy: relation,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: CGFloat(constant)
          )
        )
      }
    }

    private func makeEqual(_ attribute: NSLayoutConstraint.Attribute) {
      container.addSubviewIfNecessary(contents)
      container.cocoaView.addConstraint(
        NSLayoutConstraint(
          item: container.cocoaView,
          attribute: attribute,
          relatedBy: .equal,
          toItem: contents.cocoaView,
          attribute: attribute,
          multiplier: 1,
          constant: 0
        )
      )
    }

    private func prefer(_ attribute: NSLayoutConstraint.Attribute, of constant: Double?) {
      if let constant = constant {
        let constraint = NSLayoutConstraint(
          item: container.cocoaView,
          attribute: attribute,
          relatedBy: .equal,
          toItem: nil,
          attribute: .notAnAttribute,
          multiplier: 1,
          constant: CGFloat(constant)
        )
        #if canImport(AppKit)
          constraint.priority = NSLayoutConstraint.Priority(rawValue: 250)
        #elseif canImport(UIKit)
          constraint.priority = UILayoutPriority(rawValue: 250)
        #endif
        container.cocoaView.addConstraint(constraint)
      }
    }

    // MARK: - Properties

    private let container: AnyCocoaView
    private let contents: StabilizedView

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
