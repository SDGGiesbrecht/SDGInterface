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

    /// Terminate now.
    case now

    /// Terminate later.
    ///
    /// This requests that the system wait until the application resume termination on its own.
    case later

    /// Cancel termination.
    case cancel
}
