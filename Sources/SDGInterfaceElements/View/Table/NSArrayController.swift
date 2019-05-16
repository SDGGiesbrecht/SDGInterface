
#if !canImport(AppKit)
public class NSArrayController : NSObject {

    // MARK: - Initialization

    public init(content: [NSObject]) {
        self.content = content
    }

    // MARK: - Properties

    private var content: [NSObject]
}
#endif
