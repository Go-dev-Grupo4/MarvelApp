//
//  EventTableViewCell.swift
//  Marvel
//
//  Created by Idwall Go Dev 003 on 02/04/22.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    // MARK: Static Constants
    static let identifier = "EventTableViewCell"
    
    // MARK: View Components
    lazy var eventImageView: UIImageView! = {
        let imageView = UIImageView(frame: .zero)
        
        imageView.image = UIImage(systemName: "photo.artframe")
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .secondarySystemBackground
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius =  40
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var eventContentStackView: UIStackView! = {
        let stackView = UIStackView()
        
        stackView.spacing = 5
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()

    lazy var eventHeaderContentStackView: UIStackView! = {
        let stackView = UIStackView()
        
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var eventMessageContentStackView: UIStackView! = {
        let stackView = UIStackView()
        
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.font = UIFont.systemFont(ofSize: 17, weight: .light)
        label.textColor = .label
        label.textAlignment = .left
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: Public Methods
    func setupUI(event: ResultData) {
        
        configEventImageView(event: event)
        configEventContentStackView(with: event)
    }
    
    // MARK: Private Methods for config components

    private func configEventImageView(event: ResultData) {
      
        addSubview(eventImageView)
        
        NSLayoutConstraint.activate([
            eventImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            eventImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            eventImageView.heightAnchor.constraint(equalToConstant: 80),
            eventImageView.widthAnchor.constraint(equalToConstant: 80)
        ])
        
        if let path = event.thumbnail?.path,
           let thumbnailExtension = event.thumbnail?.thumbnailExtension,
           let url = URL(string: "\(path)/portrait_xlarge.\(thumbnailExtension)") {
            eventImageView.kf.setImage(with: url)
        }
    }
    
    private func configEventContentStackView(with event: ResultData) {
        addSubview(eventContentStackView)
        
        NSLayoutConstraint.activate([
            eventContentStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            eventContentStackView.leadingAnchor.constraint(equalTo: eventImageView.trailingAnchor, constant: 15),
            eventContentStackView.heightAnchor.constraint(equalToConstant: 80),
            eventContentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
        
        eventContentStackView.addArrangedSubview(eventHeaderContentStackView)
        eventContentStackView.addArrangedSubview(eventMessageContentStackView)
        configEventHeaderContentStackView(with: event)
        configEventMessageContentStackView(with: event)
    }
    
    private func configEventHeaderContentStackView(with event: ResultData) {
        eventHeaderContentStackView.addArrangedSubview(titleLabel)
        
        configTitleLabel(with: event.title ?? "Title")
    }
    
    private func configEventMessageContentStackView(with event: ResultData) {
        eventMessageContentStackView.addArrangedSubview(descriptionLabel)
        
        configDescriptionLabel(with: event.description ?? "No description")
    }

    private func configTitleLabel(with title: String) {
        titleLabel.text = title
    }
    
    private func configDescriptionLabel(with description: String) {
        descriptionLabel.text = description
    }
}
