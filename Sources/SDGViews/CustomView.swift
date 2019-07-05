
#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif

public class AnyNativeView: View {

    // MARK: - Initialization
    
    #if canImport(AppKit)
    // @documentation(AnyNativeView.init(_:))
    /// Wraps a native view.
    ///
    /// - Parameters:
    ///     - native: The native view.
    public init(_ native: NSView) {
        self.native = native
    }
    #elseif canImport(UIKit)
    // #documentation(AnyNativeView.init(_:))
    /// Wraps a native view.
    ///
    /// - Parameters:
    ///     - native: The native view.
    public init(_ native: UIView) {
        self.native = native
    }
    #endif

    // MARK: - View

    #if canImport(AppKit)
    public var native: NSView
    #elseif canImport(UIKit)
    public var native: UIView
    #endif
}
