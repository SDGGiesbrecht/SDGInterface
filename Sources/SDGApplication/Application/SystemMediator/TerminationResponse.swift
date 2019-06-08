/*
 TerminationResponse.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A response to a request to terminate.
public enum TerminationResponse {

    // MARK: - Initialization

    #if canImport(AppKit)
    public init(_ native: NSApplication.TerminateReply) {
        switch native {
        case .terminateNow:
            self = .now
        case .terminateLater:
            self = .later
        case .terminateCancel:
            self = .cancel
        @unknown default:
            self = .now
        }
    }
    #endif

    // MARK: - Cases

    /// Terminate now.
    case now

    /// Terminate later.
    ///
    /// This requests that the system wait until the application resume termination on its own.
    case later

    /// Cancel termination.
    case cancel

    // MARK: - Properties

    #if canImport(AppKit)
    public var native: NSApplication.TerminateReply {
        switch self {
        case .now:
            return .terminateNow
        case .later:
            return .terminateLater
        case .cancel:
            return .terminateCancel
        }
    }
    #endif
}
