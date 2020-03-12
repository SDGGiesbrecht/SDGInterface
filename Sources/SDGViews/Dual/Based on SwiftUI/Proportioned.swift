/*
 Proportioned.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(SwiftUI) || canImport(AppKit) || canImport(UIKit)
  #if canImport(SwiftUI)
    import SwiftUI
  #endif
  #if canImport(AppKit)
    import AppKit
  #endif
  #if canImport(UIKit)
    import UIKit
  #endif

  import SDGLogic
  import SDGMathematics

  import SDGInterfaceBasics

  /// The result of `aspectRatio(_:contentMode:)`.
  @available(watchOS 6, *)
  public struct Proportioned<Content>: LegacyView where Content: LegacyView {

    // MARK: - Initialization

    internal init(
      content: Content,
      aspectRatio: Double?,
      contentMode: SDGInterfaceBasics.ContentMode
    ) {
      self.content = content
      self.aspectRatio = aspectRatio
      self.contentMode = contentMode
    }

    // MARK: - Properties

    private let content: Content
    private let aspectRatio: Double?
    private let contentMode: SDGInterfaceBasics.ContentMode

    // MARK: - LegacyView

    #if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
      public func cocoa() -> CocoaView {
        return useSwiftUIOrFallback(to: {

          // Parameter Resolution

          let cocoaContent = content.cocoa()

          let resolvedRatio: Double
          if let specified = aspectRatio {
            resolvedRatio = specified
          } else {
            let intrinsicSize = cocoaContent.intrinsicSize()
            guard intrinsicSize.height ≠ 0 ∧ intrinsicSize.width ≠ 0 else {
              // No meaningful aspect ratio.
              return self.cocoa()
            }
            resolvedRatio = intrinsicSize.height ÷ intrinsicSize.width
          }

          // Constraints

          let container = CocoaView()

          container.centre(subview: cocoaContent)
          cocoaContent.lock(aspectRatio: resolvedRatio)

          func limitDimensions(by relation: NSLayoutConstraint.Relation) {
            container.constrain((cocoaContent, .width), toBe: relation, (container, .width))
            container.constrain((cocoaContent, .height), toBe: relation, (container, .height))
          }
          switch contentMode {
          case .fill:
            limitDimensions(by: .greaterThanOrEqual)
          case .fit:
            limitDimensions(by: .lessThanOrEqual)
          }

          func preferEqual(_ attribute: NSLayoutConstraint.Attribute) {
            let constraint = NSLayoutConstraint(
              item: cocoaContent.native,
              attribute: attribute,
              relatedBy: .equal,
              toItem: container.native,
              attribute: attribute,
              multiplier: 1,
              constant: 0
            )
            constraint.priority = CocoaLayoutConstraintPriority(rawValue: 250)
            container.native.addConstraint(constraint)
          }
          preferEqual(.width)
          preferEqual(.height)

          return container
        })
      }
    #endif
  }

  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  extension Proportioned: View, ViewShims where Content: View {

    // MARK: - View

    #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
      public func swiftUI() -> some SwiftUI.View {
        return content.swiftUI().aspectRatio(
          aspectRatio.map({ CGFloat($0) }),
          contentMode: SwiftUI.ContentMode(contentMode)
        )
      }
    #endif
  }
#endif
