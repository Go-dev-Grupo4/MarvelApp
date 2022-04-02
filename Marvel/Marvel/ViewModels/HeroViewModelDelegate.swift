//
//  HeroViewModelDelegate.swift
//  Marvel
//
//  Created by Matheus Lenke on 31/03/22.
//

import Foundation
import UIKit

protocol HeroViewModelDelegate: AnyObject {
    
    func heroFetchWithSuccess()
    func errorToFetchHero(_ error: String)
}
