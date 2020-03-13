/*
 FrameContainer.swift

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

  import SDGLogic

  import SDGInterfaceBasics

  internal struct FrameContainer<ContentView>: CocoaViewImplementation
  where ContentView: LegacyView {

    // MARK: - Initialization

    internal init(
      content: ContentView,
      minWidth: Double?,
      idealWidth: Double?,
      maxWidth: Double?,
      minHeight: Double?,
      idealHeight: Double?,
      maxHeight: Double?,
      alignment: SDGInterfaceBasics.Alignment
    ) {
      self.content = content.cocoa()
      self.container = CocoaView()

      handleDimension(
        .width,
        minimum: minWidth,
        ideal: idealWidth,
        maximum: maxWidth,
        intrinsic: { $0.width }
      )
      handleDimension(
        .height,
        minimum: minHeight,
        ideal: idealHeight,
        maximum: maxHeight,
        intrinsic: { $0.height }
      )
      preferEqual(.width)
      preferEqual(.height)

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

    private func handleDimension(
      _ attribute: NSLayoutConstraint.Attribute,
      minimum: Double?,
      ideal: Double?,
      maximum: Double?,
      intrinsic: (Size) -> Double
    ) {
      if minimum == nil, maximum == nil {
        make(attribute, .equal, to: intrinsic(content.cocoa().intrinsicSize()))
      } else if minimum ≠ nil, maximum == nil {
        make(attribute, .greaterThanOrEqual, to: minimum)
        prefer(attribute, of: minimum)
      } else {
        make(attribute, .greaterThanOrEqual, to: minimum)
        prefer(attribute, of: ideal)
        make(attribute, .lessThanOrEqual, to: maximum)
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
        container.cocoa().native.addConstraint(
          NSLayoutConstraint(
            item: container.cocoa().native,
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
      container.addSubviewIfNecessary(content)
      container.cocoa().native.addConstraint(
        NSLayoutConstraint(
          item: container.cocoa().native,
          attribute: attribute,
          relatedBy: .equal,
          toItem: content.cocoa().native,
          attribute: attribute,
          multiplier: 1,
          constant: 0
        )
      )
    }

    private func preferEqual(_ attribute: NSLayoutConstraint.Attribute) {
      let constraint = NSLayoutConstraint(
        item: content.cocoa().native,
        attribute: attribute,
        relatedBy: .equal,
        toItem: container.cocoa().native,
        attribute: attribute,
        multiplier: 1,
        constant: 0
      )
      constraint.priority = LayoutConstraintPriority.NativeType(.frameFill)
      container.cocoa().native.addConstraint(constraint)
    }

    private func prefer(_ attribute: NSLayoutConstraint.Attribute, of constant: Double?) {
      if let constant = constant {
        let constraint = NSLayoutConstraint(
          item: container.cocoa().native,
          attribute: attribute,
          relatedBy: .equal,
          toItem: nil,
          attribute: .notAnAttribute,
          multiplier: 1,
          constant: CGFloat(constant)
        )
        container.cocoa().native.addConstraint(constraint)
      }
    }

    // MARK: - Properties

    private let container: CocoaView
    private let content: CocoaView

    // MARK: - View

    public func cocoa() -> CocoaView {
      return container.cocoa()
    }
  }
#endif
