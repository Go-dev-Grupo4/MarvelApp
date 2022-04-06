//
//  EventsViewController.swift
//  Marvel
//
//  Created by SP11601 on 02/04/22.
//

import UIKit

class EventsViewController: UIViewController {

    var viewModel: EventsViewModel?
    var heroId: Int?
    var events: [ComicsItem] = []
    
    private var state: ViewState = .normal {
        didSet {
            DispatchQueue.main.async {
                self.setupView()
            }
        }
    }
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.tintColor = .red
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
    private func setupView() {
        switch state {
        case .loading:
            print("loading")
            startLoading()
        case .normal:
            print("normal")
            stopLoading()
            self.eventsTableView.reloadData()
        case .error:
            print("error")
            stopLoading()
            // Notificar o usuário que algo deu errado
        }
    }
    
    lazy var eventsTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        delegates()
        configUI()
        
        fetchEvent()
    }
    
    private func delegates() {
        
        eventsTableView.delegate = self
        eventsTableView.dataSource = self
    }
    
    private func registerCell() {
        eventsTableView.register(EventTableViewCell.self, forCellReuseIdentifier: EventTableViewCell.identifier)
    }
    
    private func configUI(){

        view.backgroundColor = .systemBackground
        title = "Events"
        state = .loading
        
        view.addSubview(eventsTableView)
        
        NSLayoutConstraint.activate([
            eventsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            eventsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            eventsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            eventsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
        
        registerCell()

    }

    private func startLoading() {
        eventsTableView.isHidden = true
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        activityIndicator.startAnimating()
    }
    
    private func stopLoading() {
        activityIndicator.removeFromSuperview()
        eventsTableView.isHidden = false
    }
    
    private func fetchEvent() {
        guard let heroId = heroId else {
            return
        }
        
        viewModel = EventsViewModel(services: EventListService())
        
        viewModel?.delegate = self
        
        viewModel?.fetchEvents(heroId: heroId)
    }
}

extension EventsViewController: ResultViewModelDelegate {
    func fetchWithSuccess() {
        state = .normal
    }
    
    func errorToFetchResult(_ error: String) {
        state = .error
    }
}

extension EventsViewController: UITableViewDelegate {
    
}

extension EventsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.events?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = eventsTableView.dequeueReusableCell(withIdentifier: EventTableViewCell.identifier, for: indexPath) as? EventTableViewCell,
              let event = viewModel?.events?[indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.setupUI(event: event)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
        
    }
}
