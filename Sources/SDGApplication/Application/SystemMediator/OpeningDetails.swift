
/// Details about opening a file.
public struct OpeningDetails {

    /// The system is requesting that no user interface be presented.
    public let withoutUserInterface: Bool

    /// The system is requesting that the application remove the file when it is done with it.
    public let asTemporaryFile: Bool

    #if canImport(UIKit)
    /// The options.
    public let options: [UIApplication.OpenURLOptionsKey : Any]
    #endif
}
