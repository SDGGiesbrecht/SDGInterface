/*
 Layered.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2020–2021 Jeremy David Giesbrecht and the SDGInterface project contributors.

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

import SDGMathematics

/// The result of `background(_:alignment:)`.
@available(watchOS 6, *)
public struct Layered<Foreground, Background>: LegacyView
where Foreground: LegacyView, Background: LegacyView {

  // MARK: - Initialization

  internal init(
    foreground: Foreground,
    background: Background,
    alignment: SDGInterface.Alignment
  ) {
    self.foreground = foreground
    self.background = background
    self.alignment = alignment
  }

  // MARK: - Properties

  private let foreground: Foreground
  private let background: Background
  private let alignment: SDGInterface.Alignment

  // MARK: - LegacyView

  #if canImport(AppKit) || (canImport(UIKit) && !os(watchOS))
    public func cocoa() -> CocoaView {
      return useSwiftUIOrFallback(to: {
        let container = CocoaView()
        let background = self.background.cocoa()
        let foreground = self.foreground.cocoa()

        container.addSubviewIfNecessary(background)
        switch alignment.horizontal {
        case .leading:
          container.constrain((background, .leading), toBe: .equal, (container, .leading))
        case .centre:
          container.constrain((background, .centerX), toBe: .equal, (container, .centerX))
        case .trailing:
          container.constrain((background, .trailing), toBe: .equal, (container, .trailing))
        }
        switch alignment.vertical {
        case .top:
          container.constrain((background, .top), toBe: .equal, (container, .top))
        case .centre:
          container.constrain((background, .centerY), toBe: .equal, (container, .centerY))
        case .bottom:
          container.constrain((background, .bottom), toBe: .equal, (container, .bottom))
        }

        container.disableAutoresizingMask()
        container.fill(with: foreground, margin: 0)

        container.constrain(
          (background, .width),
          toBe: .equal,
          (container, .width),
          priority: .frameFill
        )
        container.constrain(
          (background, .height),
          toBe: .equal,
          (container, .height),
          priority: .frameFill
        )

        return container
      })
    }
  #endif
}

@available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
extension Layered: View, ViewShims where Foreground: View, Background: View {

  // MARK: - View

  #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
    public func swiftUI() -> some SwiftUI.View {
      return foreground.swiftUI().background(
        background.swiftUI(),
        alignment: SwiftUI.Alignment(alignment)
      )
    }
  #endif
}

#if canImport(SwiftUI) && !(os(iOS) && arch(arm))
  @available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *)
  internal struct LayeredPreviews: PreviewProvider {
    internal static var previews: some SwiftUI.View {

      func circle(radius: CGFloat) -> SwiftUI.AnyView {
        let diameter = radius × 2
        return SwiftUI.AnyView(
          Ellipse()
            .fill(Color.black)
            .frame(width: diameter, height: diameter)
            .border(Color.green)
        )
      }

      return Group {

        previewBothModes(
          circle(radius: 16)
            .background(
              SwiftUI.AnyView(
                Color.red
                  .frame(width: 48, height: 48)
              )
            )
            .adjustForLegacyMode()
            .border(Color.blue)
            .frame(width: 128, height: 64),
          name: "red"
        )

        previewBothModes(
          circle(radius: 16)
            .background(
              SwiftUI.AnyView(
                Color.red
                  .frame(width: 48, height: 48)
              ),
              alignment: .topLeading
            )
            .adjustForLegacyMode()
            .border(Color.blue)
            .frame(width: 128, height: 64),
          name: "red, .topLeading"
        )

        previewBothModes(
          circle(radius: 16)
            .background(
              SwiftUI.AnyView(
                Color.red
                  .frame(width: 48, height: 48)
              ),
              alignment: .bottomTrailing
            )
            .adjustForLegacyMode()
            .border(Color.blue)
            .frame(width: 128, height: 64),
          name: "red, .bottomTrailing"
        )

        previewBothModes(
          SwiftUI.AnyView(
            Ellipse()
              .aspectRatio(1, contentMode: .fit)
              .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .centre)
              .background(Colour.red)
              .adjustForLegacyMode()
          )
          .frame(width: 128, height: 64)
          .padding(1)
          .border(Color.gray, width: 1),
          name: "Behind Filling Frame"
        )
      }
    }
  }
#endif
