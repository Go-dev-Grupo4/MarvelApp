//
//  Coordinator.swift
//  Marvel
//
//  Created by Idwall Go Dev 003 on 05/04/22.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get }
    var navigationController: UINavigationController { get }

    func start()
}
