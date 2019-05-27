
import Dispatch

import SDGLocalization

import SDGInterfaceLocalizations

extension Error {

    // MARK: - Display

    /// Displays the error to the user.
    public func display() { // @exempt(from: tests) Requires user interaction.
        #if canImport(AppKit)
        let cocoaError = self as NSError
        var info = cocoaError.userInfo
        info[NSLocalizedDescriptionKey] = localizedDescription
        let modified = NSError(domain: cocoaError.domain, code: cocoaError.code, userInfo: info)
        NSAlert(error: modified).runModal()
        #else
        let alert = UIAlertController(title: localizedDescription, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(
            title: String(UserFacing<StrictString, InterfaceLocalization>({ localization in
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "Okay"
                }
            }).resolved()),
            style: .cancel,
            handler: nil))
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        #endif
    }
}
