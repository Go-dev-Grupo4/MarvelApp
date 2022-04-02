//
//  ViewController.swift
//  Marvel
//
//  Created by Matheus Lenke on 30/03/22.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Variables
    var viewModel: HeroViewModel?
    
    private enum ViewState {
        case loading
        case normal
        case error
    }
    
    private var state: ViewState = .normal {
        didSet {
            DispatchQueue.main.async {
                self.setupView()
            }
        }
    }
    
    private func setupView() {
        switch state {
        case .loading:
            print("loading")
            startLoading()
        case .normal:
            print("normal")
            stopLoading()
            self.collectionView.reloadData()
        case .error:
            print("error")
            stopLoading()
            // Notificar o usuário que algo deu errado
        }
    }
    
    // MARK: - UI Elements
    
    lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    lazy var appearence: UINavigationBarAppearance! = {
        var appearence = UINavigationBarAppearance()
        appearence.shadowColor = .red
        appearence.backgroundColor = .red
        appearence.titleTextAttributes = [.foregroundColor: UIColor.systemBackground]
        appearence.largeTitleTextAttributes = [.foregroundColor: UIColor.systemBackground]
        return appearence
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.tintColor = .red
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        viewModel?.delegate = self
        
        title = "Marvel Characters"
        
        state = .loading
        
        registerCell()
        configUI()
        delegates()
        fetchHero()
    }
    
    // MARK: - Private functions
    
    private func registerCell() {
        collectionView.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: CharacterCollectionViewCell.identifier)
    }
    
    private func configUI() {
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
        configCollectionViewLayout()
        configNavigationBar()
    }
    
    private func configCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    private func configNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .label
        navigationController?.navigationBar.standardAppearance = appearence
        navigationController?.navigationBar.compactAppearance = appearence
        navigationController?.navigationBar.scrollEdgeAppearance = appearence
    }

    private func delegates() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    private func fetchHero() {
        guard let viewModel = viewModel else { return state = .error }
        viewModel.fetchHero()
    }
    
    private func startLoading() {
        collectionView.isHidden = true
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        activityIndicator.startAnimating()
    }
    
    private func stopLoading() {
        activityIndicator.removeFromSuperview()
        collectionView.isHidden = false
    }
}

// MARK: - HeroViewModelDelegate

extension ViewController: HeroViewModelDelegate {
    func heroFetchWithSuccess() {
        print("Success")
        state = .normal
    }
    
    func errorToFetchHero(_ error: String) {
        print("Error")
        state = .error
    }
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsViewController = DetailsViewController()
        
        detailsViewController.hero = viewModel?.heroes?[indexPath.item]
        
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.identifier, for: indexPath) as? CharacterCollectionViewCell else { return UICollectionViewCell() }
        
        if let hero = viewModel?.heroes?[indexPath.row] {
            cell.setup(with: hero)
        }
        cell.backgroundColor = .red
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.heroes?.count ?? 0
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.bounds.width * 0.45
        return CGSize(width: width, height: width * 1.5 + 22.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}

