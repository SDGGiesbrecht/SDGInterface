/*
 PaddingContainer.swift

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
  import SDGCollections

  import SDGInterfaceBasics

  internal struct PaddingContainer: CocoaViewImplementation {

    // MARK: - Initialization

    internal init(contents: LegacyView, edges: Edge.Set, width: Double?) {
      self.contents = StabilizedView(contents)
      self.container = AnyCocoaView()

      for edge in Edge.allCases {
        var spacing = width
        if ¬edges.contains(Edge.Set(edge)) {
          spacing = 0
        }
        handle(edge: edge, spacing: spacing)
      }
    }

    private func handle(edge: Edge, spacing width: Double?) {
      let axis: Axis
      switch edge {
      case .top, .bottom:
        axis = .vertical
      case .leading, .trailing:
        axis = .horizontal
      }

      let spacing: Spacing
      if let specific = width {
        spacing = .specific(specific)
      } else {
        spacing = .automatic
      }

      let constraintString: String
      switch edge {
      case .top, .leading:
        constraintString = "|\(spacing.string)[contents]"
      case .trailing, .bottom:
        constraintString = "[contents]\(spacing.string)|"
      }

      container.addSubviewIfNecessary(contents)

      #if canImport(AppKit)
        let viewDictionary: [String: NSView]
      #elseif canImport(UIKit)
        let viewDictionary: [String: UIView]
      #endif
      viewDictionary = ["contents": contents.cocoaView]

      let visualFormat = "\(axis.string)\(constraintString)"
      let constraints = NSLayoutConstraint.constraints(
        withVisualFormat: visualFormat,
        options: [],
        metrics: nil,
        views: viewDictionary
      )
      cocoaView.addConstraints(constraints)
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
