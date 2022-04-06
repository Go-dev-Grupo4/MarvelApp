//
//  AppCoordinator.swift
//  Marvel
//
//  Created by Idwall Go Dev 003 on 05/04/22.
//

import UIKit

class AppCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    
    private(set) var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {

        flowHome()
        
    }

    private func flowHome() {
        
        let homeCoordinator = MainCoordinator.init(navigationController: navigationController)
        childCoordinators.append(homeCoordinator)
        
        homeCoordinator.start()
    }
}
