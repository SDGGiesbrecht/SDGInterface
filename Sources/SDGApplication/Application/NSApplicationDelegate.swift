
#if canImport(AppKit)
internal class NSApplicationDelegate: NSObject, AppKit.NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        #warning("Not implemented yet.")
        print("Launched.")
    }
}
#endif
