//
//  ViewController.swift
//  MovieApp
//
//  Created by Zhangir Tastemir on 3/7/20.
//  Copyright © 2020 Akysh Akan. All rights reserved.
//

import UIKit
import SnapKit

class FeaturedViewController: UIViewController {
    
    enum Constants {
        enum Title {
            static let viewTitle = "Featured"
            static let nowPlaying = "Now playing"
            static let topRated = "Top Rated"
            static let popular = "Popular"
            static let upcoming = "Upcoming"
        }
        enum Identifiers {
            static let sectionCell = "SectionCell"
            static let collectionViewCell = "CollectionViewCell"
        }
    }
    
    private let viewModel = FeaturedViewModel()
    
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        makeUI()
        parseData()
        NetworkManager.getGenres { (genres) in
            GenreManager.shared.genres = genres
        }
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SectionTableViewCell.self, forCellReuseIdentifier: Constants.Identifiers.sectionCell)
        tableView.register(MoviesTableViewCell.self, forCellReuseIdentifier: Constants.Identifiers.collectionViewCell)
        tableView.separatorStyle = .none
        
    }
    
    func parseData() {
        
        DispatchQueue.global(qos: .userInitiated).async {
            let dispatchGroup = DispatchGroup()
            
            dispatchGroup.enter()
            NetworkManager.getNowPlayingMovies(page: 1) { [weak self] movies in
                guard let self = self else { return }
                self.viewModel.listItems.append(SectionItem(label: Constants.Title.nowPlaying))
                self.viewModel.listItems.append(MovieItem(movies: movies))
                self.tableView.reloadData()
                dispatchGroup.leave()
            }
            dispatchGroup.wait()
            
            dispatchGroup.enter()
            NetworkManager.getTopRatedMovies(page: 1) { [weak self] movies in
                guard let self = self else { return }
                self.viewModel.listItems.append(SectionItem(label: Constants.Title.topRated))
                self.viewModel.listItems.append(MovieItem(movies: movies))
                self.tableView.reloadData()
                dispatchGroup.leave()
            }
            dispatchGroup.wait()
            
            dispatchGroup.enter()
            NetworkManager.getPopularMovies(page: 1) { [weak self] movies in
                guard let self = self else { return }
                self.viewModel.listItems.append(SectionItem(label: Constants.Title.popular))
                self.viewModel.listItems.append(MovieItem(movies: movies))
                self.tableView.reloadData()
                dispatchGroup.leave()
            }
            dispatchGroup.wait()
            
            dispatchGroup.enter()
            NetworkManager.getUpcomingMovies(page: 1) { [weak self] movies in
                guard let self = self else { return }
                self.viewModel.listItems.append(SectionItem(label: Constants.Title.upcoming))
                self.viewModel.listItems.append(MovieItem(movies: movies))
                self.tableView.reloadData()
                dispatchGroup.leave()
            }
            dispatchGroup.wait()
        }
    }
    
    // objc methods
    @objc func buttonTapped(_ sender: UIButton) {
        
        var title: String = ""
        
        switch sender.tag {
        case 0:
            title = Constants.Title.nowPlaying
        case 2:
            title = Constants.Title.topRated
        case 4:
            title = Constants.Title.popular
        case 6:
            title = Constants.Title.upcoming
        default:
            break
        }
        
        let vm = MoviesViewModel(title: title)
        let movieVC = MoviesViewController(viewModel: vm)
        navigationController?.pushViewController(movieVC, animated: true)
    }
    
}


// MARK: - UI
private extension FeaturedViewController {
    func makeUI() {
        navigationItem.title = Constants.Title.viewTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            if #available(iOS 11, *){
                $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                $0.left.right.bottom.equalToSuperview()
            } else {
                $0.edges.equalToSuperview()
            }
            
        }
    }
}

// MARK: - table view delegate
extension FeaturedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.listItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.listItems[indexPath.row]
        
        switch item.itemType {
        case .section:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.sectionCell, for: indexPath) as! SectionTableViewCell
            cell.configure(item: item as! SectionItem)
            cell.nextButton.tag = indexPath.row
            cell.nextButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            cell.selectionStyle = .none
            return cell
        case .movies:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.collectionViewCell, for: indexPath) as! MoviesTableViewCell
            cell.configure(item: item as! MovieItem)
            cell.delegate = self
            return cell
        }
    }
    
}

extension FeaturedViewController: MoviesTableViewCellDelegate {
    func pushToMovieDescriptionVC(movie: Movie) {
        let vm = MovieDescriptionViewModel(movie: movie)
        let vc = MovieDescriptionViewController(viewModel: vm)
        navigationController?.pushViewController(vc, animated: true)
    }
}

