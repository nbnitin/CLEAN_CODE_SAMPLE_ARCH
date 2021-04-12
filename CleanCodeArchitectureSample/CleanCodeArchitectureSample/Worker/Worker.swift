//
//  Worker.swift
//  CleanCodeArchitectureSample
//
//  Created by Nitin Bhatia on 4/5/21.
//

import Foundation

class Worker {
    
    var dataStore: DataProviderProtocol
    
    init(dataStore: DataProviderProtocol) {
        self.dataStore = dataStore
    }
}
