//
//  HeroViewModel.swift
//  Marvel
//
//  Created by Matheus Lenke on 31/03/22.
//

import Foundation

class HeroViewModel {
    
    weak var delegate: ResultViewModelDelegate?
    
    private var services: HeroListServiceProtocol
    
    var hero: ApiResponse?
    
    var heroes: [Hero]?
    
    var coordinator: HomeCoordinator?
    
    init(services: HeroListServiceProtocol, coordinator: HomeCoordinator) {
        self.services = services
        self.coordinator = coordinator
    }
    
    func fetchHero() {
        services.execute { result in
            switch result {
            case .success(let hero):
                self.success(hero: hero)
            case .failure(let error):
                self.error(error: "Error: \(error.localizedDescription)")
            }
        }
    }
    
    func selectedHero(hero: Hero) {
        coordinator?.flowDetail(with: hero)
    }
    
    func showEvents(hero: Hero) {
        coordinator?.flowEvents(with: hero)
    }
    
    func showEasterEgg() {
        coordinator?.flowEaterEgg()
    }
    
    private func success(hero: ApiResponse) {
        self.hero = hero
        self.heroes = hero.data?.results
        delegate?.fetchWithSuccess()
    }
    
    private func error(error: String) {
        delegate?.errorToFetchResult(error)
    }
}
