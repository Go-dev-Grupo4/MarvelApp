//
//  HomeRequest.swift
//  Marvel
//
//  Created by Matheus Lenke on 30/03/22.
//

import Foundation

enum Request : URLRequestProtocol {
    
    case home
    case details
    case events
    
    /// The API's base url
    var baseURL: String {
        switch self {
        case .home:
            return Environment.baseURL
        case .details:
            return Environment.baseURL
        case .events:
            return "\(Environment.baseURL)/characters"
        }
       
    }
    
    /// Defines the endpoint we want to hit
    var path: String {
        switch self {
        case .home:
            return "characters"
        case .details:
            return "details"
        case .events:
            return "events"
        }
    }
    
    /// The API's query params
    var queryParams: String {
        /*
         timestamp
         
         MD5 = timestamp + private + public
         */
        let timestamp = NSDate().timeIntervalSince1970.description
        switch self {
        case .home:
            let hash = HashMD5Hex(string: "\(timestamp)\(Environment.privateKey)\(Environment.publicKey)")
            return "limit=30&ts=\(timestamp)&apikey=\(Environment.publicKey)&hash=\(hash)"
        case .details:
            return "details=124010"
        case .events:
            let hash = HashMD5Hex(string: "\(timestamp)\(Environment.privateKey)\(Environment.publicKey)")
            return "ts=\(timestamp)&apikey=\(Environment.publicKey)&hash=\(hash)"
        }
    }
    
    /// Relative to the method we want to call, that was defined with an enum above
    var method: HTTPMethod {
        switch self {
        case .home, .events:
            return .get
        case .details:
            return .post
        }
    }
    
}
