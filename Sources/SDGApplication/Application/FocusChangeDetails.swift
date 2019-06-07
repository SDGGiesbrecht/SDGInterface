
/// Details about a change in system focus.
public struct FocusChangeDetails {

    #if canImport(AppKit)
    /// The notification.
    public let notification: Notification
    #endif
}
