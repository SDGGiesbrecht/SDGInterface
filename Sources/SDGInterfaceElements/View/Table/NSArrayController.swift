
#if !canImport(AppKit)
public class NSArrayController : NSObject {

    // MARK: - Initialization

    public override init() {
        self.content = []
    }

    public init(content: [NSObject]) {
        self.content = content
    }

    // MARK: - Properties

    private var content: [NSObject]

    public var arrangedObjects: [NSObject] {
        return content
    }

    public var automaticallyRearrangesObjects: Bool = false
}
#endif
