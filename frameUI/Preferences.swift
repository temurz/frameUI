//
//  Preferences.swift
//  Tedr
//
//  Created by GK on 11/03/25.
//
import UIKit
import Foundation
public struct AppPref {
    private static let DEVICE_TOKEN = "device_token"
    private static let BIOPIN = "bio_pin"
    
    public static var isNotificationsEnabled: Bool {
        set {
            Pref.save("isNotificationsEnabled", value: newValue ? "Y" : "N")
        }
        get {
            if Pref.get("isNotificationsEnabled")?.isEmpty ?? true {
                return false
            }
            return Pref.get("isNotificationsEnabled") == "Y"
        }
    }
    
    public static var isAuthorized: Bool {
        set {
            Pref.save("isAuthorized", value: newValue ? "Y" : "N")
        }
        get {
            if Pref.get("isAuthorized")?.isEmpty ?? true {
                return false
            }
            return Pref.get("isAuthorized") == "Y"
        }
    }
    
    public static var biopinEnabled: Bool? {
        set {
            Pref.save(AppPref.BIOPIN, value: newValue! ? "Y" : "N")
        }
        get {
            if Pref.get(AppPref.BIOPIN)?.isEmpty ?? true {
                return false
            }
            return Pref.get(AppPref.BIOPIN) == "Y"
        }
    }
    
    public static var deviceToken: String? {
        set {
            Pref.save(AppPref.DEVICE_TOKEN, value: newValue ?? "")
        }
        get {
            return Pref.get(AppPref.DEVICE_TOKEN) ?? ""
        }
    }
    
    public static var test: String? {
        set {
            Pref.save("test", value: newValue ?? "")
        }
        get {
            return Pref.get("test") ?? ""
        }
    }
}

public class TemplateListEntity<T: Codable>: Codable {
    public var list: [T]
    
    public init(list: [T]) {
        self.list = list
    }
}

public final class Pref {
    public static func toValue<T: Codable>(_ data: Data) -> T? {
        return try? JSONDecoder().decode(T.self, from: data)
    }
    
    public static func toJson<T: Codable>(value: T) -> String? {
        let encoder = JSONEncoder()
        encoder.dataEncodingStrategy = .base64
        if let data = try? encoder.encode(value) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    fileprivate static let userDefault = UserDefaultsR.sharedDefaults()
    
    public static func save(_ key: String, value: String) {
        userDefault.setObject(value as AnyObject, key: key)
    }
    
    public static func saveInteger(_ key: String, value: Int) {
        userDefault.setInteger(value, key: key)
    }
    
    public static func save<T:Codable>(_ key: String, value: T) {
        if let json = Pref.toJson(value: value) {
            Pref.save(key, value: json)
        }
    }
    
    public static func get<T:Codable>(_ key: String) -> T? {
        let json = userDefault.getString(key)
        if let j = json {
            if let data = j.data(using: .utf8) {
                return Pref.toValue(data)
            }
        }
        return nil
    }
    
    public static func get(_ key: String) -> String? {
        return userDefault.getString(key)
    }
    
    public static func getInteger(_ key: String) -> Int? {
        return userDefault.getInt(key)
    }
    
    public static func remove(_ key: String) {
        userDefault.removeObject(key)
    }
}

open class UserDefaultsR {
    fileprivate var userDef = Foundation.UserDefaults(suiteName: "group.io.pigeon") ?? Foundation.UserDefaults.standard
    
    open subscript (key: String) -> AnyObject? {
        get {
            return getObject(key)
        }
        set (val) {
            setObject(val!, key: key)
        }
    }
    
    open subscript (key: String) -> Bool {
        get {
            return getBool(key)
        }
        set (val) {
            setBool(val, key: key)
        }
    }
    
    open subscript (key: String) -> Int {
        get {
            return getInt(key)
        }
        set (val) {
            setInteger(val, key: key)
        }
    }
    
    open subscript (key: String) -> Double {
        get {
            return getDouble(key)
        }
        set (val) {
            setDouble(val, key: key)
        }
    }
    
    open subscript (key: String) -> Float {
        get {
            return getFloat(key)
        }
        set (val) {
            setFloat(val, key: key)
        }
    }
    
    open subscript (key: String) -> URL? {
        get {
            return getUrl(key)
        }
        set (val) {
            setUrl(val!, key: key)
        }
    }
    
    
    open class func sharedDefaults() -> UserDefaultsR {
        struct Singleton {
            static let singleton = UserDefaultsR()
        }
        return Singleton.singleton
    }
    
    open func setObject(_ obj: AnyObject, key: String) {
        userDef.set(obj, forKey: key)
        userDef.synchronize()
    }
    
    open func getObject(_ key: String) -> AnyObject? {
        return userDef.object(forKey: key) as AnyObject?
    }
    
    open func removeObject(_ key: String) {
        userDef.removeObject(forKey: key)
    }
    
    open func getBool(_ key: String) -> Bool {
        return userDef.bool(forKey: key)
    }
    
    open func getInt(_ key: String) -> Int {
        return userDef.integer(forKey: key)
    }
    
    open func getDouble(_ key: String) -> Double {
        return userDef.double(forKey: key)
    }
    
    open func getFloat(_ key: String) -> Float {
        return userDef.float(forKey: key)
    }
    
    open func getString(_ key: String) -> String? {
        return userDef.string(forKey: key)
    }
    
    open func getStringArray(_ key: String) -> [String]? {
        return userDef.stringArray(forKey: key)
    }
    
    open func getArray(_ key: String) -> [AnyObject]? {
        return userDef.array(forKey: key) as [AnyObject]?
    }

    open func getDictionary(_ key: String) -> [String: AnyObject]? {
        return userDef.dictionary(forKey: key) as [String : AnyObject]?
    }
    
    open func getData(_ key: String) -> Data? {
        return userDef.data(forKey: key)
    }
    
    open func getUrl(_ key: String) -> URL? {
        return userDef.url(forKey: key)
    }
    
    open func setBool(_ value: Bool, key: String) {
        userDef.set(value, forKey: key)
        userDef.synchronize()
    }
    
    open func setInteger(_ value: Int, key: String) {
        userDef.set(value, forKey: key)
        userDef.synchronize()
    }
    
    open func setDouble(_ value: Double, key: String) {
        userDef.set(value, forKey: key)
        userDef.synchronize()
    }
    
    open func setFloat(_ value: Float, key: String) {
        userDef.set(value, forKey: key)
        userDef.synchronize()
    }
    
    open func setUrl(_ url: URL, key: String) {
        userDef.set(url, forKey: key)
        userDef.synchronize()
    }
}

