//
//  SearchViewController.swift
//  MovieApp
//
//  Created by Zhangir Tastemir on 5/8/20.
//  Copyright © 2020 Akysh Akan. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    enum Constants {
        static let viewTitle = "Search"
        static let cellId = "searchCell"
    }
    
    let viewModel = SearchViewModel()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: Constants.cellId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        makeUI()
    }

}

// make UI
extension SearchViewController {
    func setupNavigationBar() {
        navigationItem.title = Constants.viewTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Movies"
        self.navigationItem.searchController = searchController
    }
    
    func makeUI() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            if #available(iOS 11, *) {
                $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            } else {
                $0.top.top.equalTo(topLayoutGuide.snp.top)
                $0.bottom.equalTo(bottomLayoutGuide.snp.bottom)
            }
            
            $0.left.right.equalToSuperview()
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellId, for: indexPath) as! SearchTableViewCell
        let currentCell = viewModel.movies[indexPath.row]
        cell.movie = currentCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = viewModel.movies[indexPath.row]
        let vm = MovieDescriptionViewModel(movie: currentCell)
        navigationController?.pushViewController(MovieDescriptionViewController(viewModel: vm), animated: true)
    }
    
}

// search bar delegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == "" {
            viewModel.movies.removeAll()
            tableView.reloadData()
        }
        
        NetworkManager.searchMovies(query: searchText) { (movies) in
            self.viewModel.movies = movies
            self.tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.movies.removeAll()
        tableView.reloadData()
    }
}
