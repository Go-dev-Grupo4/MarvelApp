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
        image.layer.cornerRadius = 35
        image.clipsToBounds = true
        image.image = UIImage(named: "Presentation")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "NOSSO SUPER HEROI FAVORITO!!!\n\nDesenvolvedor iOS e entusiasta, profissional com mais de 10 anos de experiência atuando em carreiras de desenvolvedor.\n\n E A QUEM SOMOS TÃO GRATOS POR ESSAS SEMANAS DE ENSINAMENTOS TÃO VALIOSO!! BRIGADÃO AMIGO!!!\n\n (NEM TODO HEROI USA CAPA)"
        label.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var appearence: UINavigationBarAppearance! = {
        var appearence = UINavigationBarAppearance()
        appearence.shadowColor = .orange
        appearence.backgroundColor = .orange
        appearence.titleTextAttributes = [.foregroundColor: UIColor.systemBackground]
        appearence.largeTitleTextAttributes = [.foregroundColor: UIColor.systemBackground]
        return appearence
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .orange
        
        configContent()
        title = "Secret Hero"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .systemBackground
        navigationController?.navigationBar.standardAppearance = appearence
        navigationController?.navigationBar.compactAppearance = appearence
        navigationController?.navigationBar.scrollEdgeAppearance = appearence
    }
    private func configContent() {
        
        //view.addSubview(titleLabel)
        view.addSubview(heroImage)
        view.addSubview(descriptionLabel)
        
//        NSLayoutConstraint.activate([
//            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            titleLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
//        ])
        
        NSLayoutConstraint.activate([
            heroImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            heroImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            heroImage.heightAnchor.constraint(equalToConstant: 350)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: heroImage.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            descriptionLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
}
