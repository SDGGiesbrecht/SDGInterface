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

  internal struct PaddingContainer<Content>: CocoaViewImplementation where Content: LegacyView {

    // MARK: - Initialization

    internal init(content: Content, edges: Edge.Set, width: Double?) {
      self.content = content.stabilize()
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

      container.addSubviewIfNecessary(content)

      #if canImport(AppKit)
        let viewDictionary: [String: NSView]
      #elseif canImport(UIKit)
        let viewDictionary: [String: UIView]
      #endif
      viewDictionary = ["contents": content.cocoaView]

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
    private let content: Stabilized<Content>

    // MARK: - View

    public func cocoa() -> CocoaView {
      return container.cocoa()
    }
  }
#endif
