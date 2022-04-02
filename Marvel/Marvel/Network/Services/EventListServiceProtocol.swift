//
//  EventListServiceProtocol.swift
//  Marvel
//
//  Created by Idwall Go Dev 003 on 02/04/22.
//

import Foundation

import Foundation

enum EventError: Error {
    case error(String)
    case urlInvalid
    case noDataAvailable
    case noProcessData
}

protocol EventListServiceProtocol: AnyObject {
    
    func execute(heroId: Int, handler: @escaping(Result<Hero, HeroError>) -> Void)
    
}
