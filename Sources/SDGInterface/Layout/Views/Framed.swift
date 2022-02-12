/*
 Framed.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2022 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

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

/// The result of `frame(minWidth:idealWidth:maxWidth:minHeight:idealHeight:maxHeight:alignment:)`.
@available(watchOS 6, *)
public struct Framed<Content>: LegacyView where Content: LegacyView {

  // MARK: - Initialization

  internal init(
    content: Content,
    minWidth: Double?,
    idealWidth: Double?,
    maxWidth: Double?,
    minHeight: Double?,
    idealHeight: Double?,
    maxHeight: Double?,
    alignment: SDGInterface.Alignment
  ) {
    self.content = content
    self.minWidth = minWidth
    self.idealWidth = idealWidth
    self.maxWidth = maxWidth
    self.minHeight = minHeight
    self.idealHeight = idealHeight
    self.maxHeight = maxHeight
    self.alignment = alignment
  }

  // MARK: - Properties

  private let content: Content
  private let minWidth: Double?
  private let idealWidth: Double?
  private let maxWidth: Double?
  private let minHeight: Double?
  private let idealHeight: Double?
  private let maxHeight: Double?
  private let alignment: SDGInterface.Alignment

  // MARK: - LegacyView

  #if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
    public func cocoa() -> CocoaView {
      return useSwiftUIOrFallback(to: {

        let content = self.content.cocoa()
        let container = CocoaView()
        container.addSubviewIfNecessary(content)

        func handleDimension(
          _ attribute: NSLayoutConstraint.Attribute,
          minimum: Double?,
          ideal: Double?,
          maximum: Double?,
          intrinsic: (Size) -> Double
        ) {
          func constrainSize(
            toBe relation: NSLayoutConstraint.Relation,
            _ constant: Double?
          ) {
            if let constant = constant,
              constant ≠ .infinity
            {
              container.constrain(attribute, toBe: relation, constant)
            }
          }
          func prefer(size constant: Double?) {
            if let constant = constant {
              container.constrain(attribute, toBe: .equal, constant)
            }
          }
          if minimum == nil, maximum == nil {
            constrainSize(toBe: .equal, intrinsic(content.intrinsicSize()))
          } else if minimum ≠ nil, maximum == nil {
            constrainSize(toBe: .greaterThanOrEqual, minimum)
            prefer(size: minimum)
          } else {
            constrainSize(toBe: .greaterThanOrEqual, minimum)
            prefer(size: ideal)
            constrainSize(toBe: .lessThanOrEqual, maximum)
          }

          container.constrain(
            (content, attribute),
            toBe: .equal,
            (container, attribute),
            priority: .frameFill
          )
        }

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

        func align(_ attribute: NSLayoutConstraint.Attribute) {
          container.constrain((content, attribute), toBe: .equal, (container, attribute))
        }
        switch alignment.horizontal {
        case .leading:
          align(.leading)
        case .centre:
          align(.centerX)
        case .trailing:
          align(.trailing)
        }
        switch alignment.vertical {
        case .top:
          align(.top)
        case .centre:
          align(.centerY)
        case .bottom:
          align(.bottom)
        }

        return container
      })
    }
  #endif
}

@available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
extension Framed: View, ViewShims where Content: View {

  // MARK: - View

  #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
    public func swiftUI() -> some SwiftUI.View {
      return content.swiftUI().frame(
        minWidth: minWidth.map({ CGFloat($0) }),
        idealWidth: idealWidth.map({ CGFloat($0) }),
        maxWidth: maxWidth.map({ CGFloat($0) }),
        minHeight: minHeight.map({ CGFloat($0) }),
        idealHeight: idealHeight.map({ CGFloat($0) }),
        maxHeight: maxHeight.map({ CGFloat($0) }),
        alignment: SwiftUI.Alignment(alignment)
      )
    }
  #endif
}

#if canImport(SwiftUI) && !(os(iOS) && arch(arm))
  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  internal struct FramedPreviews: PreviewProvider {
    internal static var previews: some SwiftUI.View {

      func circle(radius: CGFloat) -> SwiftUI.AnyView {
        let diameter = radius × 2
        return SwiftUI.AnyView(
          Ellipse()
            .fill(Color.black)
            .frame(width: diameter, height: diameter)
        )
      }

      return Group {

        previewBothModes(
          circle(radius: 16)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .adjustForLegacyMode()
            .background(Color.red)
            .frame(width: 128, height: 64),
          name: "(≤ ∞) × (≤ ∞)"
        )

        previewBothModes(
          circle(radius: 16)
            .frame(idealWidth: 48, idealHeight: 48, alignment: .topLeading)
            .adjustForLegacyMode()
            .background(Color.red)
            .frame(width: 128, height: 64),
          name: "48 × 48, ↖"
        )

        previewBothModes(
          circle(radius: 16)
            .frame(minWidth: 48, minHeight: 48, alignment: .bottomTrailing)
            .adjustForLegacyMode()
            .background(Color.red)
            .frame(width: 128, height: 64),
          name: "(≥ 48) × (≥ 48), ↘"
        )

        previewBothModes(
          circle(radius: 16)
            .frame()
            .adjustForLegacyMode()
            .background(Color.red)
            .frame(width: 128, height: 64),
          name: "∅"
        )

        previewBothModes(
          SwiftUI.AnyView(
            SwiftUI.AnyView(Ellipse())
              .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .centre)
              .adjustForLegacyMode()
              .frame(width: 128, height: 64)
          ),
          name: "(≤ ∞) × (≤ ∞), no internal frame"
        )
      }
    }
  }
#endif
