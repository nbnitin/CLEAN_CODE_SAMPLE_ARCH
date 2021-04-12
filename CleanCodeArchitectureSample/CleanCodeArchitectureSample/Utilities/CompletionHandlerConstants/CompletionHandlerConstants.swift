//
//  CompletionHandlerConstants.swift
//  CleanCodeArchitectureSample
//
//  Created by Nitin Bhatia on 4/5/21.
//

import Foundation
typealias GetAllUsersResponseHandler<T> = ([AllUsers]?, AlertResponse?, Error?) -> Void
typealias DictionaryNetworkResponseHandler<T> = (T?, AlertResponse?, Error?) -> Void
typealias ArrayNetworkResponseHandler<T> = ([T]?, AlertResponse?, Error?) -> Void
