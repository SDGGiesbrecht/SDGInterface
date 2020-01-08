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
    }

    private func apply(aspectRatio: CGFloat) {
      contents.cocoaView.addConstraint(
        NSLayoutConstraint(
          item: contents.cocoaView,
          attribute: .width,
          relatedBy: .equal,
          toItem: contents.cocoaView,
          attribute: .height,
          multiplier: aspectRatio,
          constant: 0
        )
      )
    }

    private func limit(
      _ attribute: NSLayoutConstraint.Attribute,
      by relation: NSLayoutConstraint.Relation
    ) {
      container.cocoaView.addConstraint(
        NSLayoutConstraint(
          item: contents.cocoaView,
          attribute: attribute,
          relatedBy: relation,
          toItem: container.cocoaView,
          attribute: attribute,
          multiplier: 1,
          constant: 0
        )
      )
    }

    private func limitDimensions(by relation: NSLayoutConstraint.Relation) {
      limit(.width, by: relation)
      limit(.height, by: relation)
    }

    private func preferEqual(_ attribute: NSLayoutConstraint.Attribute) {
      let constraint = NSLayoutConstraint(
        item: contents.cocoaView,
        attribute: attribute,
        relatedBy: .equal,
        toItem: container.cocoaView,
        attribute: attribute,
        multiplier: 1,
        constant: 0
      )
      #if canImport(AppKit)
        constraint.priority = NSLayoutConstraint.Priority(rawValue: 250)
      #elseif canImport(UIKit)
        constraint.priority = UILayoutPriority(rawValue: 250)
      #endif
      container.cocoaView.addConstraint(constraint)
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
