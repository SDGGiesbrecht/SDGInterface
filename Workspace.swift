/*
 Workspace.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import WorkspaceConfiguration

let configuration = WorkspaceConfiguration()
configuration._applySDGDefaults()

configuration.documentation.currentVersion = Version(0, 7, 0)

configuration.documentation.projectWebsite = URL(
  string: "https://sdggiesbrecht.github.io/SDGInterface"
)!
configuration.documentation.documentationURL = URL(
  string: "https://sdggiesbrecht.github.io/SDGInterface"
)!
configuration.documentation.api.yearFirstPublished = 2018
configuration.documentation.repositoryURL = URL(
  string: "https://github.com/SDGGiesbrecht/SDGInterface"
)!

configuration.documentation.localizations = ["🇨🇦EN"]

configuration._applySDGOverrides()
configuration._validateSDGStandards()

configuration.testing.exemptionTokens.insert(
  TestCoverageExemptionToken("codingNotSupported", scope: .previousLine)
)

configuration.documentation.api.ignoredDependencies = [

  // SDGCornerstone
  "SDGCalendar",
  "SDGCollections",
  "SDGCornerstoneLocalizations",
  "SDGLocalizationTestUtilities",
  "SDGLogic",
  "SDGLogicTestUtilities",
  "SDGMathematics",
  "SDGPersistence",
  "SDGPersistenceTestUtilities",
  "SDGTesting",
  "SDGText",
  "SDGXCTestUtilities",

  // Swift
  "Dispatch",
  "Foundation",
  "XCTest",
]
