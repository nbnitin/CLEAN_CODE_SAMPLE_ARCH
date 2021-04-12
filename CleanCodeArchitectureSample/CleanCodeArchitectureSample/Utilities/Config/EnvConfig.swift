//
//  EnvConfig.swift
//  CleanCodeArchitectureSample
//
//  Created by Nitin Bhatia on 4/5/21.
//

import Foundation
public enum Environment {
    enum Keys {
        enum Plist {
            enum Configurations {
                static let backendUrl = "Backend Url"
                static let imageInspectUrl = "Image Inspect Url"
                static let imageInspectLabelInfoUrl = "Image Inspect Label Info Url"
                static let imageInspectImageUrl = "Image Inspect Image Url"
                
            }
        }
    }
    
    static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("plist file not found")
        }
        return dict
    }()
    
    static let configDictionary: [String: Any] = {
        guard let dict: [String: Any] = Bundle.main.infoDictionary?[
            "Configurations"
            ] as? [String: Any] else {
                fatalError("config not found in plist")
        }
        return dict
    }()
    
    static let backendUrl: String =  {
        guard let url = Environment.configDictionary[
            Keys.Plist.Configurations.backendUrl
            ] as? String else {
                fatalError("backend url not set")
        }
        return url
    }()
    
    static let imageInspectUrl: String =  {
        guard let url = Environment.configDictionary[
            Keys.Plist.Configurations.imageInspectUrl
            ] as? String else {
                fatalError("image inspect url not set")
        }
        return url
    }()
    
    static let imageInspectLabelInfoUrl: String =  {
        guard let url = Environment.configDictionary[
            Keys.Plist.Configurations.imageInspectLabelInfoUrl
            ] as? String else {
                fatalError("image inspect label info url not set")
        }
        return url
    }()
    
    static let imageInspectImageUrl: String =  {
        guard let url = Environment.configDictionary[
            Keys.Plist.Configurations.imageInspectImageUrl
            ] as? String else {
                fatalError("image inspect image url not set")
        }
        return url
    }()
    
}
