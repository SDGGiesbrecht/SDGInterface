
#if canImport(AppKit)
// @documentation(Screen)
/// An alias for `NSScreen` or `UIScreen`.
public typealias Screen = NSScreen
#elseif canImport(UIKit)
// #documentation(Screen)
public typealias Screen = UIScreen
#endif
