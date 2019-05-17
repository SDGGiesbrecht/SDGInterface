
#if !canImport(AppKit)
/// A drop‐in replacement for some uses of `AppKit`’s `NSArrayController` in `UIKit` environments.
public class NSArrayController : NSObject {

    // MARK: - Initialization

    public override init() {
        self.content = []
    }

    /// Creates an array controller with a content array.
    ///
    /// - Parameters:
    ///     - content: The content array.
    public init(content: [NSObject]) {
        self.content = content
    }

    // MARK: - Properties

    private var content: [NSObject]

    /// The arranged content.
    public var arrangedObjects: [NSObject] {
        return content
    }

    /// Whether or not the controller automatically rearranges its content.
    public var automaticallyRearrangesObjects: Bool = false
}
#endif
