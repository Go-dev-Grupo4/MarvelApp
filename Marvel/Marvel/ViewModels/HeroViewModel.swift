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
    
    var hero: Hero?
    
    var heroes: [ResultData]?
    
    init(services: HeroListServiceProtocol) {
        self.services = services
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
    
    private func success(hero: Hero) {
        self.hero = hero
        self.heroes = hero.data?.results
        delegate?.fetchWithSuccess()
    }
    
    private func error(error: String) {
        delegate?.errorToFetchResult(error)
    }
}
