//
//  SimilarMoviesCollectionView.swift
//  MovieApp
//
//  Created by Zhangir Tastemir on 5/8/20.
//  Copyright © 2020 Akysh Akan. All rights reserved.
//

import UIKit

protocol SimilarMoviesCollectionViewDelegate: class {
    func pushToMovieDescriptionVC(movie: Movie)
}

class SimilarMoviesCollectionView: UICollectionView {
    
    enum Constants {
        static let cellId = "similarMovieCell"
    }
    
    weak var similarMovieDelegate: SimilarMoviesCollectionViewDelegate?
    
    var movies: [Movie] = []

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        register(SimilarMoviewCollectionViewCell.self, forCellWithReuseIdentifier: Constants.cellId)
        backgroundColor = .white
        delegate = self
        dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SimilarMoviesCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellId, for: indexPath) as! SimilarMoviewCollectionViewCell
        cell.movie = movies[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentItem = movies[indexPath.row]
        similarMovieDelegate?.pushToMovieDescriptionVC(movie: currentItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.size.width / 1.5, height: frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
}
