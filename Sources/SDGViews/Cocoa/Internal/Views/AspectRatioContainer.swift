/*
 AspectRatioContainer.swift

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
  import SDGMathematics

  import SDGInterfaceBasics

  internal struct AspectRatioContainer<Content>: CocoaViewImplementation where Content: LegacyView {

    // MARK: - Static Methods

    internal static func constraining(
      _ view: Content,
      toAspectRatio aspectRatio: Double?,
      contentMode: ContentMode
    ) -> AnyView {
      return AspectRatioContainer(
        content: view,
        aspectRatio: aspectRatio,
        contentMode: contentMode
      ).map({ AnyView($0) }) ?? AnyView(view)
    }

    // MARK: - Initialization

    /// Creates an aspect ratio container where meaningful.
    ///
    /// If no aspect ratio is specified and the view has no intrinsic aspect ratio, the initializer will fail and return `nil`.
    private init?(content: Content, aspectRatio: Double?, contentMode: ContentMode) {
      self.content = content.stabilize()
      self.container = AnyCocoaView()

      let resolvedRatio: CGFloat
      if let specified = aspectRatio {
        resolvedRatio = CGFloat(specified)
      } else {
        let intrinsicSize = self.content.cocoa().native.intrinsicContentSize
        guard intrinsicSize.height ≠ 0 ∧ intrinsicSize.width ≠ 0 else {
          return nil
        }
        resolvedRatio = intrinsicSize.height ÷ intrinsicSize.width
      }
      applyConstraints(aspectRatio: resolvedRatio, contentMode: contentMode)
    }

    private func applyConstraints(aspectRatio: CGFloat, contentMode: ContentMode) {
      container.centre(subview: content)
      apply(aspectRatio: aspectRatio)

      switch contentMode {
      case .fill:
        limitDimensions(by: .greaterThanOrEqual)
      case .fit:
        limitDimensions(by: .lessThanOrEqual)
      }

      preferEqual(.width)
      preferEqual(.height)
    }

    private func apply(aspectRatio: CGFloat) {
      content.cocoa().native.addConstraint(
        NSLayoutConstraint(
          item: content.cocoa().native,
          attribute: .width,
          relatedBy: .equal,
          toItem: content.cocoa().native,
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
      container.cocoa().native.addConstraint(
        NSLayoutConstraint(
          item: content.cocoa().native,
          attribute: attribute,
          relatedBy: relation,
          toItem: container.cocoa().native,
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
        item: content.cocoa().native,
        attribute: attribute,
        relatedBy: .equal,
        toItem: container.cocoa().native,
        attribute: attribute,
        multiplier: 1,
        constant: 0
      )
      constraint.priority = CocoaLayoutConstraintPriority(rawValue: 250)
      container.cocoa().native.addConstraint(constraint)
    }

    // MARK: - Properties

    private let container: AnyCocoaView
    private let content: Stabilized<Content>

    // MARK: - View

    public func cocoa() -> CocoaView {
      return container.cocoa()
    }
  }
#endif
