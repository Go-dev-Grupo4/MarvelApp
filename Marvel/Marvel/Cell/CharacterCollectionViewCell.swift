//
//  CharacterCollectionViewCell.swift
//  Marvel
//
//  Created by Matheus Lenke on 01/04/22.
//

import UIKit
import Kingfisher

class CharacterCollectionViewCell: UICollectionViewCell {
    static let identifier = "CharacterCollectionViewCell"
    
    lazy var characterStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var characterImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var characterNameLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.numberOfLines = 1
        view.font = UIFont.systemFont(ofSize: 19)
        view.textColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        backgroundColor = .red
        configCharacterStackView()
        configCharacterImageView()
        configCharacterNameLabel()
    }
    
    private func configCharacterStackView() {
        addSubview(characterStackView)
        NSLayoutConstraint.activate([
            characterStackView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            characterStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            characterStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            characterStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
        ])
    }
    
    private func configCharacterImageView() {
        characterStackView.addArrangedSubview(characterImageView)
    }
    
    private func configCharacterNameLabel() {
        characterStackView.addArrangedSubview(characterNameLabel)
    }
    
    func setup(with character: ResultData) {
        if let path = character.thumbnail?.path,
           let thumbnailExtension = character.thumbnail?.thumbnailExtension,
           let url = URL(string: "\(path)/portrait_xlarge.\(thumbnailExtension)") {
            characterImageView.kf.setImage(with: url)
        }
        characterNameLabel.text = character.name
    }
    
}
