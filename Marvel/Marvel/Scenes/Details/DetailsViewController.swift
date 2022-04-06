//
//  DetailsViewController.swift
//  Marvel
//
//  Created by Matheus Lenke on 01/04/22.
//

import UIKit

class DetailsViewController: UIViewController {

    var hero: Hero?
    
    var viewModel: HeroViewModel?
    
    lazy var verticalStackView: UIStackView = {
        let stack = UIStackView()
        
        stack.layer.cornerRadius = 50
        stack.clipsToBounds = true
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.backgroundColor = .systemBackground
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var characterImageView: UIImageView = {
        let image = UIImageView()
        
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        image.image = UIImage(systemName: "photo.artframe")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = true
        return image
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "No Description"
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
    
    lazy var appearence: UINavigationBarAppearance! = {
        var appearence = UINavigationBarAppearance()
        appearence.shadowColor = Color.background
        appearence.backgroundColor = Color.background
        appearence.titleTextAttributes = [.foregroundColor: UIColor.systemBackground]
        appearence.largeTitleTextAttributes = [.foregroundColor: UIColor.systemBackground]
        return appearence
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradient = CAGradientLayer()

        gradient.frame = view.safeAreaLayoutGuide.layoutFrame
        gradient.colors = [
            UIColor.red.cgColor
            , UIColor(red: 12/255, green: 34/255, blue: 56/255, alpha: 1).cgColor]

        view.layer.insertSublayer(gradient, at: 250)

        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configNavigationBar()
    }
    @objc private func callEventsViewController() {

        guard let hero = hero else {
            return
        }

        viewModel?.showEvents(hero: hero)
    }

    private func configNavigationBar() {
        navigationItem.rightBarButtonItem = eventsButton
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .systemBackground
        navigationController?.navigationBar.standardAppearance = appearence
        navigationController?.navigationBar.compactAppearance = appearence
        navigationController?.navigationBar.scrollEdgeAppearance = appearence
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
                
        view.addSubview(verticalStackView)
        configureVerticalStackView()
    }
    
    private func configureVerticalStackView() {
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
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
