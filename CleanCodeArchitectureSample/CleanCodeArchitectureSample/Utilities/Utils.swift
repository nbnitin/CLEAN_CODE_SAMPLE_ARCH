//
//  Utils.swift
//  CleanCodeArchitectureSample
//
//  Created by Nitin Bhatia on 4/12/21.
//

import Foundation
import Alamofire

class Utils {
    
    internal static func fileExists(at path: String) -> Bool {
        
        if !FileManager.default.fileExists(atPath: path) {
            return self .createDirectory(at: path)
        }
        return true
    }
    
    @discardableResult
    internal static func createDirectory(at path: String) -> Bool {
        do {
            try FileManager.default.createDirectory(atPath: path,
                                                    withIntermediateDirectories: true,
                                                    attributes: nil)
        } catch {
           print(error.localizedDescription)
            return false
        }
        return false
    }
    
    internal static func searchDirectory(with name: String,
                                         in directory: FileManager.SearchPathDirectory) -> String {
        return NSSearchPathForDirectoriesInDomains(directory, .userDomainMask, true).first! + "/" + name
    }
    
    internal static func tempDirectory() throws -> String {
        return try self.directoryInsideDocumentsWithName(name: "temp")
    }
    
    internal static func directoryInsideDocumentsWithName(name: String,
                                                          create: Bool = true) throws -> String {
        let directoryPath = self.searchDirectory(with: name, in: .documentDirectory)
        if create && !self.fileExists(at: directoryPath) {
            self.createDirectory(at: directoryPath)
        }
        return directoryPath
    }
    
    @discardableResult
    internal static func deleteFile(at path: String) throws -> Bool {
        let fileManager = FileManager.default
        if fileManager.isDeletableFile(atPath: path) {
            try fileManager.removeItem(atPath: path)
        }
        return false
    }
}
