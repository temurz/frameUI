//
//  Localization.swift
//  Tedr
//
//  Created by GK on 11/03/25.
//

import Foundation
struct Localization {
    static let ENGLISH = "en"
    static let RUSSIAN = "ru"
    static let UZ = "uz"
    static let CHINESE = "zh"
    static let LATVIAN = "lv"
    static let JAPAN = "ja"
    static let GERMAN = "de"
    static let FRENCH = "fr"
    
    static var language: String = getLocaleCode() //"en-US"
    
    static func setLanguage(_ language: String) {
        self.language = language
    }
    
    static func getLanguage() -> String {
        return self.language
    }
    
    static func getBundle() -> Bundle? {
        let path = Bundle.main.path(forResource: self.language, ofType: "lproj")
        let bundle = Bundle(path: path!)
        
        return bundle
    }
    
    static func getValue(_ key: String, comment: String?) -> String {
        let path = Bundle.main.path(forResource: self.language, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return bundle!.localizedString(forKey: key, value: comment, table: nil)
    }
    
    static func getValue(_ key: String) -> String {
        return self.getValue(key, comment: key)
    }
    
    static func saveLocaleCode(languageCode: String) {
        Pref.save("LOCALE_CODE", value: languageCode)
        Localization.setLanguage(languageCode)
    }
    
    static func getLocaleCode() -> String {
        let storedLanguage = Pref.get("LOCALE_CODE")
        if storedLanguage == nil {
            if let currentLanguage = Locale.current.languageCode {
                if currentLanguage == Localization.RUSSIAN {
                    return Localization.RUSSIAN
                }
                if currentLanguage == Localization.UZ {
                    return Localization.UZ
                }
                if currentLanguage == Localization.CHINESE {
                    return Localization.CHINESE
                }
                if currentLanguage == Localization.LATVIAN {
                    return Localization.LATVIAN
                }
                if currentLanguage == Localization.JAPAN {
                    return Localization.JAPAN
                }
                if currentLanguage == Localization.GERMAN {
                    return Localization.GERMAN
                }
                if currentLanguage == Localization.FRENCH {
                    return Localization.FRENCH
                }
            }
            return Localization.ENGLISH
        }
        
        return storedLanguage!
    }
}

func translate(_ key: String) -> String {
    return Localization.getValue(key)
}

extension Strings {
    static func switchLocalizationBundleDuringRuntime(forKey: String, table: String, fallbackValue: String) -> String {
        let bundle = Localization.getBundle() ?? Bundle.main
        return NSLocalizedString(forKey, tableName: table, bundle: bundle, comment: "")
    }
}
