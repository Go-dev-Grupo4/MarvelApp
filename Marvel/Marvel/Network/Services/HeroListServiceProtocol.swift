//
//  HeroListServiceProtocol.swift
//  Marvel
//
//  Created by Matheus Lenke on 30/03/22.
//

import Foundation

enum HeroError: Error {
    case error(String)
    case urlInvalid
    case noDataAvailable
    case noProcessData
}

protocol HeroListServiceProtocol: AnyObject {
    
    func execute(handler: @escaping(Result<ApiResponse, HeroError>) -> Void)
    
}
