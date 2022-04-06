//
//  HomeCoordinator.swift
//  Marvel
//
//  Created by Idwall Go Dev 003 on 05/04/22.
//

import UIKit

class MainCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    
    private(set) var navigationController: UINavigationController
    
    private var viewModel: HeroViewModel?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {

        let service = HeroListService()
        viewModel = HeroViewModel(services: service, coordinator: self)
        let viewController = HomeViewController()
        viewController.viewModel = viewModel
        
        navigationController.setViewControllers([viewController], animated: true)
    }
    
    func flowDetail(with hero: Hero) {
        
        let detailViewController = DetailsViewController()
        detailViewController.hero = hero
        detailViewController.viewModel = viewModel
        
        navigationController.pushViewController(detailViewController, animated: true)
    }

    func flowEvents(with hero: Hero) {
        
        let service = EventListService()
        let eventsViewModel = EventsViewModel(services: service)
        eventsViewModel.coordinator = self
        
        let viewController = EventsViewController()
        viewController.viewModel = eventsViewModel
        viewController.heroId = hero.id
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func flowEaterEgg() {
        let destinationVC = EasterEggViewController()
            
        navigationController.pushViewController(destinationVC, animated: true)
    }
}
