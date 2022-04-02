//
//  EasterEggViewController.swift
//  Marvel
//
//  Created by Idwall Go Dev 003 on 02/04/22.
//

import UIKit

class EasterEggViewController: UIViewController {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "SECRET HERO"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var heroImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Presentation")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "NOSSO SUPER HEROI FAVORITO!!!\n\nDesenvolvedor iOS e entusiasta, profissional com mais de 10 anos de experiência atuando em carreiras de desenvolvedor Back-end / Mobile developer.\n\n E A QUEM SOMOS TÃO GRATOS POR ESSAS SEMANAS DE ENSINAMENTOS TÃO VALIOSO!! BRIGADÃO AMIGO!!!\n\n\n (NEM TODO HEROI USA CAPA)"
        label.font = UIFont.systemFont(ofSize: 19)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var contentStackView: UIStackView! = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .orange
        
        configContentStackView()

    }
    
    private func configContentStackView() {
        view.addSubview(contentStackView)
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            contentStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            contentStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            contentStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50)
        ])
        
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(heroImage)
        contentStackView.addArrangedSubview(descriptionLabel)

    }

    
}
