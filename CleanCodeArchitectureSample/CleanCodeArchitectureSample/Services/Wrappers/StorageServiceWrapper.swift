//
//  StorageServiceWrapper.swift
//  CleanCodeArchitectureSample
//
//  Created by Nitin Bhatia on 4/5/21.
//

import Foundation

protocol StorageServiceWrapperProtocol {
    @discardableResult
    func set(value: String, forKey key: String) -> Bool
    
    func get(key: String) -> Any?
    
    @discardableResult
    func delete(key: String) -> Bool
    
    var authToken: String? { get set }
    var refreshToken: String? { get set }
}

class StorageServiceWrapper: StorageServiceWrapperProtocol {

    static let standard =  StorageServiceWrapper()
    var keys = [String:Any]()
    var authToken: String?
    var refreshToken: String?
    
    private init() {

    }

    @discardableResult
    func set(value: String, forKey key: String) -> Bool {
        keys[key] = value
        return true
    }

    func get(key: String) -> Any? {
        return keys[key]
    }
    
    @discardableResult
    func delete(key: String) -> Bool {
        keys.removeValue(forKey: key)
        return true
    }
}

