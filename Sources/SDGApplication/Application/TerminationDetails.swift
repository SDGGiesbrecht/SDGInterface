
/// Details about a termination.
public struct TerminationDetails {

    #if canImport(AppKit)
    /// The notification.
    public let notification: Notification
    #endif
}
