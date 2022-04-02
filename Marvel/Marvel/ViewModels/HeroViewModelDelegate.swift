//
//  HeroViewModelDelegate.swift
//  Marvel
//
//  Created by Matheus Lenke on 31/03/22.
//

import Foundation
import UIKit

protocol ResultViewModelDelegate: AnyObject {
    
    func fetchWithSuccess()
    func errorToFetchResult(_ error: String)
}
