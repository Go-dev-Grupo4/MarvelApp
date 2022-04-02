//
//  DetailsViewController.swift
//  Marvel
//
//  Created by Matheus Lenke on 01/04/22.
//

import UIKit

class DetailsViewController: UIViewController {

    var hero: ResultData?
    
    lazy var verticalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.backgroundColor = .systemBackground
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var characterImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "photo.artframe")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = true
        return image
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "No Descritpion"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var eventsButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Events", style: .plain, target: self, action: #selector(callEventsViewController))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradient = CAGradientLayer()

        gradient.frame = view.safeAreaLayoutGuide.layoutFrame
        gradient.colors = [UIColor.red.cgColor, UIColor(red: 12/255, green: 34/255, blue: 56/255, alpha: 1).cgColor]

        view.layer.insertSublayer(gradient, at: 0)

        configureUI()
    }
    
    @objc private func callEventsViewController() {
        let destinationVC = EventsViewController()
        
        destinationVC.heroId = hero?.id
        
        navigationController?.pushViewController(destinationVC, animated: true)
    }

    private func configNavigationBar() {
        navigationItem.rightBarButtonItem = eventsButton
    }
    
    private func configureUI() {
        
        if let hero = hero {
            title = hero.name
            if let path = hero.thumbnail?.path,
               let thumbnailExtension = hero.thumbnail?.thumbnailExtension,
               let url = URL(string: "\(path)/portrait_xlarge.\(thumbnailExtension)") {
                characterImageView.kf.setImage(with: url)
            }
        }
        
        configNavigationBar()
        
        view.addSubview(verticalStackView)
        configureVerticalStackView()
    }
    
    private func configureVerticalStackView() {
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            verticalStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            verticalStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
        
        verticalStackView.addArrangedSubview(characterImageView)
        verticalStackView.addArrangedSubview(descriptionLabel)

        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor, constant: -20),
        ])
                
        if let description = hero?.description, !description.isEmpty {
            descriptionLabel.text = description
        }
    }
}
