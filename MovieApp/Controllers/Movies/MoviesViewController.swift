//
//  MovieDescriptionViewController.swift
//  MovieApp
//
//  Created by Zhangir Tastemir on 3/13/20.
//  Copyright © 2020 Akysh Akan. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    
    enum Constants {
        enum Title {
            static let nowPlaying = "Now playing"
            static let topRated = "Top Rated"
            static let popular = "Popular"
            static let upcoming = "Upcoming"
        }
        enum Identifiers {
            static let collectionViewCell = "MovieCell"
        }
    }
    
    var viewModel: MoviesViewModel
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    init(viewModel: MoviesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        makeUI()
        parseData()
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: Constants.Identifiers.collectionViewCell)
    }
    
    func parseData() {
        switch viewModel.title {
        case Constants.Title.nowPlaying:
            NetworkManager.getNowPlayingMovies(page: 1) { [weak self] (movies) in
                guard let self = self else { return }
                self.viewModel.movies.append(contentsOf: movies)
                self.collectionView.reloadData()
            }
        case Constants.Title.topRated:
        NetworkManager.getTopRatedMovies(page: 1) { [weak self] (movies) in
            guard let self = self else { return }
            self.viewModel.movies.append(contentsOf: movies)
            self.collectionView.reloadData()
        }
        case Constants.Title.popular:
        NetworkManager.getPopularMovies(page: 1) { [weak self] (movies) in
            guard let self = self else { return }
            self.viewModel.movies.append(contentsOf: movies)
            self.collectionView.reloadData()
        }
        case Constants.Title.upcoming:
        NetworkManager.getUpcomingMovies(page: 1) { [weak self] (movies) in
            guard let self = self else { return }
            self.viewModel.movies.append(contentsOf: movies)
            self.collectionView.reloadData()
        }
        default:
            print("Error while fetching data")
        }
        
        NetworkManager.getNowPlayingMovies(page: 1) { [weak self] (movies) in
            guard let self = self else { return }
            self.viewModel.movies.append(contentsOf: movies)
            self.collectionView.reloadData()
        }
    }
    
}

// MARK: - UI
extension MoviesViewController {
    func makeUI() {
        view.backgroundColor = .white
        
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = viewModel.title
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - Collection view delegate
extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identifiers.collectionViewCell, for: indexPath) as! MovieCollectionViewCell
        cell.configure(movie: viewModel.movies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel.movies[indexPath.row]
        let vm = MovieDescriptionViewModel(movie: item)
        let vc = MovieDescriptionViewController(viewModel: vm)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3.5, height: collectionView.frame.height / 3.7)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    
}
