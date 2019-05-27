
import Dispatch

import SDGLocalization

extension Error {

    // MARK: - Display

    /// Displays the error to the user.
    public func display() { // @exempt(from: tests) Requires user interaction.
        let cocoaError = self as NSError
        var info = cocoaError.userInfo
        info[NSLocalizedDescriptionKey] = localizedDescription
        let modified = NSError(domain: cocoaError.domain, code: cocoaError.code, userInfo: info)
        NSAlert(error: modified).runModal()
    }
}
