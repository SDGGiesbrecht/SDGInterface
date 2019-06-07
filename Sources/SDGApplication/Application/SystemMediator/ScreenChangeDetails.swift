
/// Details about a screen change.
public struct ScreenChangeDetails {

    #if canImport(AppKit)
    /// The notification.
    public let notification: Notification
    #endif
}
