//
//  EventsViewModel.swift
//  Marvel
//
//  Created by SP11601 on 02/04/22.
//

import Foundation

class EventsViewModel {
    weak var delegate: ResultViewModelDelegate?

    private var services: EventListServiceProtocol

    var heroId: Int?

    var events: [Hero]?
    
    var coordinator: MainCoordinator?

    init(services: EventListServiceProtocol) {
        self.services = services
    }

    func fetchEvents(heroId: Int?) {
        guard let heroId = heroId else {
            return
        }

        services.execute(heroId: heroId) { result in
            switch result {
            case .success(let events):
                self.success(events: events)
            case .failure(let error):
                self.error(error: "Error: \(error.localizedDescription)")
            }
        }
    }

    private func success(events: ApiResponse) {
        self.events = events.data?.results
        delegate?.fetchWithSuccess()
    }

    private func error(error: String) {
        delegate?.errorToFetchResult(error)
    }

}
