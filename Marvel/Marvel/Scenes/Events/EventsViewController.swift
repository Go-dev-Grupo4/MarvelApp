//
//  EventsViewController.swift
//  Marvel
//
//  Created by SP11601 on 02/04/22.
//

import UIKit

class EventsViewController: UIViewController {

    var events: [ComicsItem] = []
    
    lazy var eventsTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegates()
        configUI()
        
    }
    
    private func delegates() {
        
        eventsTableView.delegate = self
        eventsTableView.dataSource = self
    }
    
    private func registerCell() {
        
    }
    
    private func configUI(){

        view.backgroundColor = .yellow
        title = "Events"
        
        // Adicionar tabela
        // Configurar constraints tabela
        
        registerCell()

    }

}

extension EventsViewController: UITableViewDelegate {
    
}

extension EventsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
