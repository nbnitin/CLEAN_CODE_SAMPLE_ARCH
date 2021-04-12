//
//  AlertModel.swift
//  CleanCodeArchitectureSample
//
//  Created by Nitin Bhatia on 4/5/21.
//

import Foundation
struct AlertResponse:Error, Codable {
    var description: String
    let code: Int
    var alertType: AlertType?
    var endPoint: EndPoint?
}

enum AlertType: String , Codable {
    case network_error = "Retry"
    case close, noResultsFound = ""
    case success = "Done"
    static var offline: AlertType { .network_error }
}
