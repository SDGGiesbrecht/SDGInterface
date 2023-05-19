/*
 TerminationResponse.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019–2023 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(AppKit)
  import AppKit
#endif

/// A response to a request to terminate.
public enum TerminationResponse: CaseIterable {

  // MARK: - Initialization

  #if canImport(AppKit)
    /// Creates a termination response from a Cocoa termination response.
    ///
    /// - Parameters:
    ///     - cocoa: The Cocoa termination response.
    public init(_ cocoa: NSApplication.TerminateReply) {
      switch cocoa {
      case .terminateNow:
        self = .now
      case .terminateLater:
        self = .later
      case .terminateCancel:
        self = .cancel
      @unknown default:  // @exempt(from: tests)
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
    /// The Cocoa termination response.
    public var cocoa: NSApplication.TerminateReply {
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
