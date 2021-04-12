//
//  Login.swift
//  CleanCodeArchitectureSample
//
//  Created by Nitin Bhatia on 4/5/21.
//

import Foundation
// MARK: - Login
struct Login: Codable {
    var access_token, refresh_token: String?
    var token_type, expires_in: String?
}
