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
        label.text = "NOSSO SUPER HEROI FAVORITO!!!\n\nDesenvolvedor iOS e entusiasta, profissional com mais de 10 anos de experiência atuando em carreiras de desenvolvedor.\n\n E A QUEM SOMOS TÃO GRATOS POR ESSAS SEMANAS DE ENSINAMENTOS TÃO VALIOSO!! BRIGADÃO AMIGO!!!\n\n (NEM TODO HEROI USA CAPA)"
        label.font = UIFont.systemFont(ofSize: 19)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .orange
        
        configContent()

    }
    
    private func configContent() {
        
        view.addSubview(titleLabel)
        view.addSubview(heroImage)
        view.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            heroImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            heroImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            heroImage.heightAnchor.constraint(equalToConstant: 350)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: heroImage.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            descriptionLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
        
    }

    
}
