
/// A response to a request to terminate.
public enum TerminationResponse {

    /// Terminate now.
    case now

    /// Terminate later.
    ///
    /// This requests that the system wait until the application resume termination on its own.
    case later

    /// Cancel termination.
    case cancel
}
