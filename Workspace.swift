/*
 Workspace.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import WorkspaceConfiguration

let configuration = WorkspaceConfiguration()
configuration._applySDGDefaults()

configuration.documentation.currentVersion = Version(0, 3, 0)

configuration.documentation.projectWebsite = URL(string: "https://sdggiesbrecht.github.io/SDGInterface")!
configuration.documentation.documentationURL = URL(string: "https://sdggiesbrecht.github.io/SDGInterface")!
configuration.documentation.api.yearFirstPublished = 2018
configuration.documentation.repositoryURL = URL(string: "https://github.com/SDGGiesbrecht/SDGInterface")!

configuration.documentation.localizations = ["🇨🇦EN"]

configuration.documentation.api.encryptedTravisCIDeploymentKey = "O5o7Iu10Pk7hfyfcRBxcEw8G52INRoGCgLTDBladFxOZLx6a6yKaYu1RuYeOi2A2Y4SdGCI88Wk64rMVNh3t8j7chJUImGWTCt0Da8wOfVIub958MyXojU8ed2tKURkyfTrGm/fUc3ED0E/VGongGF8bYUOreVXFK6qJ8S2XtQROpgYA7mek25YMu9uvem8O3JvN6U+esbLmMx9n/GOkaPNcu1IOsRytbwzLdClWbkwhW8tgAF7ca9BEholyzw3LT2/9uigZaScjtifsKs+9xB6L4+3DLD9WL8+0A1YqQi1SmH1EpB7tigDe0DgEsI3ElRyJbBVfDIFRFbcmLihSc/mttBVbLVlcHD7b3jJ75jOpfBgBTH7UoYM2JHn6KzqrDp0SZXETUs6m76E5D0i6BtvqFIDU61WqIF1fKy/06/nMnt5vACeUZ9oVUfpB0QUjO78Xjziv/qsgEvoVlWgW8hjuB70MusJvNtGbWCY8cJjcx2LPqK7dEkEsx4xMc20W/SmZP8aQeGgZijuTD/kFJTryX27B1CGnRcOscSsIWiN3LiHZoV7zcM2czQxNSq3s6uIz+craAnz7H5+Ngrh5q39XSvlznlHUWhT7Is4H0sJvXAOSWYQmcbsB7ajQg5tJ5TDA5XS6GK4vyeueNXDpyWZVTVlHdzkkqbDFQP9InHs="

configuration._applySDGOverrides()
configuration._validateSDGStandards()

configuration.testing.exemptionTokens.insert(TestCoverageExemptionToken("codingNotSupported", scope: .previousLine))

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
    "XCTest"
]
