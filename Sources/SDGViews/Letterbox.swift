/*
 Letterbox.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if (canImport(AppKit) || canImport(UIKit)) && !os(watchOS)
  #if canImport(AppKit)
    import AppKit
  #endif
  #if canImport(UIKit)
    import UIKit
  #endif

  import SDGInterfaceBasics

  import SDGInterfaceLocalizations

  /// A letterboxing view.
  public final class Letterbox<Content>: CocoaViewImplementation, View where Content: View {

    // MARK: - Initialization

    /// Creates a letterbox.
    ///
    /// - Parameters:
    ///     - content: The content view.
    ///     - widthToHeight: The intended aspect ratio.
    public init(content: Content, aspectRatio widthToHeight: Double) {
      self.container = LetterboxContainer()
      self.content = content

      let intermediate = content.aspectRatio(widthToHeight, contentMode: .fit)
      AnyCocoaView(container).fill(with: StabilizedView(intermediate), margin: .specific(0))
    }

    // MARK: - Properties

    private let container: LetterboxContainer

    /// The content of the letterbox.
    public let content: Content

    /// The colour.
    public var colour: Colour? {
      get {
        return container.colour
      }
      set {
        container.colour = newValue
      }
    }

    // MARK: - View

    #if canImport(AppKit)
      public var cocoaView: NSView {
        return container
      }
    #elseif canImport(UIKit)
      public var cocoaView: UIView {
        return container
      }
    #endif
  }
#endif
