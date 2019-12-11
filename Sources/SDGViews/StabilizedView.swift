
#if canImport(SwiftUI) || canImport(AppKit) || canImport(UIKit)
#if canImport(SwiftUI) && !(os(iOS) && arch(arm))
  import SwiftUI
#endif
#if canImport(AppKit)
  import AppKit
#elseif canImport(UIKit)
  import UIKit
#endif

/// Stabilizes a view to behave with consistent reference semantics.
///
/// Wrap unknown `View` conformers in this type before using repeated accesses of `cocoaView` that assume the same instance will be returned each time.
public struct StabilizedView: View {

  // MARK: - Initialization

  public init(_ view: View) {
    self.view = view
    self.stabilizedCocoaView = AnyCocoaView(view.cocoaView)
  }

  // MARK: - Properties

  // Maintains any strong references outside the Cocoa view.
  /// The underlying view.
  public let view: View

  private let stabilizedCocoaView: AnyCocoaView

  // MARK: - View

  #if canImport(SwiftUI) && !(os(iOS) && arch(arm))
    @available(macOS 10.15, iOS 13, tvOS 13, *)
    public var swiftUIView: AnyView {
      // @exempt(from: tests) #workaround(workspace version 0.27.0, macOS 10.15 is unavailable in CI.)
      return view.swiftUIView
    }
  #endif

  #if canImport(AppKit)
    public var cocoaView: NSView {
      return stabilizedCocoaView.cocoaView
    }
  #elseif canImport(UIKit) && !os(watchOS)
    public var cocoaView: UIView {
      return stabilizedCocoaView.cocoaView
    }
  #endif
}
#endif
