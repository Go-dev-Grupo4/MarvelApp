//
//  DetailsViewController.swift
//  Marvel
//
//  Created by Matheus Lenke on 01/04/22.
//

import UIKit

class DetailsViewController: UIViewController {

    var hero: ResultHero?
    
    lazy var horizontalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.contentMode = .bottom
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var eventsLabel: UILabel = {
        let label = UILabel()
        label.text = "E\nV\nE\nN\nT\nS"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
        label.text = "BLABLALBLABLABLALBALBALBLABLABLALBLABLABLALBALBLALBALBAL"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradient = CAGradientLayer()

        gradient.frame = view.safeAreaLayoutGuide.layoutFrame
        gradient.colors = [UIColor.red.cgColor, UIColor(red: 12/255, green: 34/255, blue: 56/255, alpha: 1).cgColor]

        view.layer.insertSublayer(gradient, at: 0)

        configureUI()
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
        view.addSubview(horizontalStackView)
        configureHorizontalStackView()
    }
    
    private func configureHorizontalStackView() {
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            horizontalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            horizontalStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            horizontalStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
        horizontalStackView.addArrangedSubview(verticalStackView)
        horizontalStackView.addArrangedSubview(eventsLabel)
        configureVerticalStackView()
    }
    
    private func configureVerticalStackView() {
        verticalStackView.addArrangedSubview(characterImageView)
        verticalStackView.addArrangedSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            eventsLabel.widthAnchor.constraint(equalToConstant: 30),
            descriptionLabel.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor, constant: -20),
        ])
        
        descriptionLabel.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets"
    }

}
