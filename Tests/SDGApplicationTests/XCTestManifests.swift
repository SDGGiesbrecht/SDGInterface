#if !canImport(ObjectiveC)
import XCTest

extension APITests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__APITests = [
        ("testDemonstrations", testDemonstrations),
        ("testFetchResult", testFetchResult),
        ("testNotification", testNotification),
        ("testPreferences", testPreferences),
        ("testSystemMediator", testSystemMediator),
    ]
}

extension InternalTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__InternalTests = [
        ("testApplicationName", testApplicationName),
        ("testNSApplicationDelegate", testNSApplicationDelegate),
        ("testUIApplicationDelegate", testUIApplicationDelegate),
    ]
}

public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(APITests.__allTests__APITests),
        testCase(InternalTests.__allTests__InternalTests),
    ]
}
#endif
