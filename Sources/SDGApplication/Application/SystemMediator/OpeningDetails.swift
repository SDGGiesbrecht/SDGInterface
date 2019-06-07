
/// Details about opening a file.
public struct OpeningDetails {

    #if canImport(UIKit)
    /// The options.
    public let options: [UIApplication.OpenURLOptionsKey : Any]
    #endif
}
