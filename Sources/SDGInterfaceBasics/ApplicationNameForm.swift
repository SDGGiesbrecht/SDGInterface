/*
 ApplicationNameForm.swift

 This source file is part of the SDGInterface open source project.
 https://sdggiesbrecht.github.io/SDGInterface

 Copyright ©2019 Jeremy David Giesbrecht and the SDGInterface project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText
import SDGLocalization

import SDGInterfaceLocalizations

/// A key form a particular grammatical form of the application’s name.
public enum ApplicationNameForm {

  /// Una forma española.
  case español(Preposición)
  /// Una forma con una preposición.
  public enum Preposición {
    /// Con ninguna preposición.
    case ninguna
    /// Con «de» o «del».
    ///
    /// Por ejemplo:
    ///
    /// - «Acerca [...]»
    /// - «Salir [...]»
    /// - «Ayuda [...]»
    case de
  }

  /// An English form.
  case english(EnglishRegion)
  /// An regional dialect of English.
  public enum EnglishRegion {
    /// As spoken in the United Kingdom.
    case unitedKingdom
    /// As spoken in the United States.
    case unitedStates
    /// As spoken in Canada.
    case canada
  }

  /// Eine deutsche Form..
  case deutsch(Fall)
  /// Ein grammatikalischer Fall.
  public enum Fall {
    /// Nominativ.
    case nominativ
    /// Akkusativ.
    ///
    /// Zum Beispiel:
    ///
    /// - „Über [...]“
    /// - „[...] ausblenden“
    /// - „[...] beenden“
    case akkusativ
    /// Dativ
    ///
    /// Zum Beispiel: „Hilfe zu [...]“
    case dativ
  }

  /// Une forme française.
  case français(Préposition)
  /// Une forme avec une préposition.
  public enum Préposition {
    /// Avec aucune préposition.
    case aucune
    /// Avec « de », « d’ », « du » ou « des ».
    ///
    /// Par exemple :
    /// - « À propos [...] »
    /// - « Aide [...] »
    case de
  }

  /// Μια ελληνική μορφή.
  case ελληνικά(Πτώση)
  /// Μια γραμματική πτώση.
  public enum Πτώση {
    /// Ονομαστική.
    case ονομαστική
    /// Αιτιατική.
    ///
    /// Παραδείγματος χάριν:
    ///
    /// - «Πληροφορίες για [...]»
    /// - «Βοήθεια για [...]»
    case αιτιατική
    /// Γενική.
    ///
    /// Παραδείγματος χάριν:
    ///
    /// - «Απόκρυψη [...]»
    /// - «Τερματισμός [...]»
    case γενική
  }

  /// בעברית.
  case עברית

  public static func _isolatedForm(for localizationCode: String) -> ApplicationNameForm? {
    guard let localization = MenuBarLocalization(exactly: localizationCode) else {
      return nil
    }
    switch localization {
    case .españolEspaña:
      return .español(.ninguna)
    case .englishUnitedKingdom:
      return .english(.unitedKingdom)
    case .englishUnitedStates:
      return .english(.unitedStates)
    case .englishCanada:
      return .english(.canada)
    case .deutschDeutschland:
      return .deutsch(.nominativ)
    case .françaisFrance:
      return .français(.aucune)
    case .ελληνικάΕλλάδα:
      return .ελληνικά(.ονομαστική)
    case .עברית־ישראל:
      return .עברית
    }
  }

  /// The localized application name suitable for use in isolation.
  public static var localizedIsolatedForm: UserFacing<StrictString, ApplicationNameLocalization> {
    return UserFacing<StrictString, ApplicationNameLocalization>({ $0.correspondingIsolatedName })
  }
}
