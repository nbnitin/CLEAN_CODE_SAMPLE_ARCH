//
//  JSONHelper.swift
//  CleanCodeArchitectureSample
//
//  Created by Nitin Bhatia on 4/6/21.
//

import Foundation

extension UInt64 {
    
    func megabytes() -> UInt64 {
        return self * 1024 * 1024
    }
    
}


extension Data {
    var prettyPrintedJSONString: NSString { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data,
                                                 encoding: String.Encoding.utf8.rawValue) else { return "" }
        
        return prettyPrintedString
    }
}

class JsonHelper {
    
    class func decode<T: Decodable>(for: T.Type = T.self, with data: Data) -> T {
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
//            Logger.e("Couldn't parse \(data.prettyPrintedJSONString) as \(T.self):\n\(error)")
            fatalError("Couldn't parse \(data.prettyPrintedJSONString) as \(T.self):\n\(error)")
        }
    }
    
    class func encode<T>(_ value: T) -> [String: Any] where T: Encodable {
        do {
            let data = try JSONEncoder().encode(value)
            var params = try JSONSerialization.jsonObject(with: data,
                                                          options: .allowFragments) as! [String: Any]
            //Logger.d("Encoding \(T.self) to params : \(params)")
            let keysToRemove = params.keys.filter {
                if params[$0] == nil {
                    return true
                }
                return false
            }
            for key in keysToRemove {
                params.removeValue(forKey: key)
            }
            return params
        } catch {
          //  Logger.e("Couldn't encode \(T.self):\n\(error)")
            fatalError("Couldn't encode \(T.self):\n\(error)")
        }
    }
}
