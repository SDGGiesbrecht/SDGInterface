/*
 Workspace.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface/SDGInterface

 Copyright ©2018 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import WorkspaceConfiguration

let configuration = WorkspaceConfiguration()
configuration.applySDGDefaults()

configuration.documentation.currentVersion = Version(0, 0, 0)

configuration.documentation.projectWebsite = URL(string: "https://sdggiesbrecht.github.io/SDGInterface/SDGInterface")!
configuration.documentation.documentationURL = URL(string: "https://sdggiesbrecht.github.io/SDGInterface")!
configuration.documentation.api.yearFirstPublished = 2018
configuration.documentation.repositoryURL = URL(string: "https://github.com/SDGGiesbrecht/SDGInterface")!

configuration.supportedOperatingSystems.remove(.linux)

configuration.documentation.localizations = ["🇨🇦EN"]

configuration.documentation.readMe.shortProjectDescription["🇨🇦EN"] = "SDGInterface provides tools for implementing a graphical user interface."

configuration.documentation.readMe.quotation = Quotation(original: "Καὶ ὁ Λόγος σὰρξ ἐγένετο καὶ ἐσκήνωσεν ἐν ἡμῖν, καὶ ἐθεασάμεθα τὴν δόξαν αὐτοῦ, δόξαν ὡς μονογενοῦς παρὰ πατρός, πλήρης χάριτος καὶ ἀληθείας.")
configuration.documentation.readMe.quotation?.translation["🇨🇦EN"] = "And the Word became flesh and dwelt among us and we have watched His glory, the glory of the Only Begotten of the Father, full of grace and truth."
configuration.documentation.readMe.quotation?.link["🇨🇦EN"] = URL(string: "https://www.biblegateway.com/passage/?search=John+1&version=SBLGNT;NIV")!
configuration.documentation.readMe.quotation?.citation["🇨🇦EN"] = "‎יוחנן/Yoẖanan"

configuration.documentation.readMe.featureList["🇨🇦EN"] = [
    "\u{2D} API unification accross platforms."
    ].joinedAsLines()

configuration.documentation.readMe.exampleUsage["🇨🇦EN"] = "\u{23}example(sample)"

// [_Workaround: No key yet._]
configuration.documentation.api.encryptedTravisCIDeploymentKey = ""

configuration.applySDGOverrides()
configuration.validateSDGStandards()
