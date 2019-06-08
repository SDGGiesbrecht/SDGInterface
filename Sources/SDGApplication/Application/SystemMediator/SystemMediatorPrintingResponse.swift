/*
 SystemMediatorPrintingResponse.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A response to a request to print.
public enum SystemMediatorPrintingResponse {

    // MARK: - Initialization

    #if canImport(AppKit)
    public init(_ native: NSApplication.PrintReply) {
        switch native {
        case .printingSuccess:
            self = .success
        case .printingReplyLater:
            self = .processing
        case .printingCancelled:
            self = .cancel
        case .printingFailure:
            self = .failure
        @unknown default:
            self = .failure
        }
    }
    #endif

    // MARK: - Cases

    /// Printing succeeded.
    case success

    /// Printing began but has not completed yet.
    ///
    /// This requests that the system wait until the application reports the result of the print attempt on its own.
    case processing

    /// Cancel printing.
    case cancel

    /// Failed to print.
    case failure

    // MARK: - Properties

    #if canImport(AppKit)
    public var native: NSApplication.PrintReply {
        switch self {
        case .success:
            return .printingSuccess
        case .processing:
            return .printingReplyLater
        case .cancel:
            return .printingCancelled
        case .failure:
            return .printingFailure
        }
    }
    #endif
}
