//
//  MovieDescriptionViewController.swift
//  MovieApp
//
//  Created by Zhangir Tastemir on 4/3/20.
//  Copyright © 2020 Akysh Akan. All rights reserved.
//

import UIKit
import SafariServices

class MovieDescriptionViewController: UIViewController {
    
    let viewModel: MovieDescriptionViewModel
    
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 180)
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.contentSize = contentViewSize
        scrollView.bounds = self.view.bounds
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.frame.size = contentViewSize
        return view
    }()
    
    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let yearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let genresLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    let descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Overview"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    let videosTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Videos"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var videosCollectionView: VideosCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = VideosCollectionView(frame: .zero, collectionViewLayout: layout)
        cv.videoDelegate = self
        return cv
    }()
    
    let similarMoviesTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Similar movies"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var similarMoviesCollectionView: SimilarMoviesCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = SimilarMoviesCollectionView(frame: .zero, collectionViewLayout: layout)
        cv.similarMovieDelegate = self
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        makeUI()
        loadData()
    }
    
    init(viewModel: MovieDescriptionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadData() {
        let movie = viewModel.movie
        navigationItem.title = movie.title
        yearLabel.text = "Year: " + String(movie.releaseDate?.prefix(4) ?? "")
        genresLabel.text = "Genres: " + viewModel.getRenres()
        descriptionLabel.text = movie.overview
        if let url = viewModel.getMovieUrl() {
            posterImageView.af_setImage(withURL: url)
        }
        
        viewModel.loadVideos { (videos) in
            self.videosCollectionView.videos = videos
            self.videosCollectionView.reloadData()
        }
        
        viewModel.loadSimilarMovies { (movies) in
            self.similarMoviesCollectionView.movies = movies
            self.similarMoviesCollectionView.reloadData()
        }
    }


}

extension MovieDescriptionViewController: VideosCollectionViewDelegate {
    func playVideo(key: String) {
        let svc = SFSafariViewController(url: URL(string: "https://www.youtube.com/watch?v=\(key)")!)
        present(svc, animated: true, completion: nil)
    }
}

extension MovieDescriptionViewController: SimilarMoviesCollectionViewDelegate {
    func pushToMovieDescriptionVC(movie: Movie) {
        let vm = MovieDescriptionViewModel(movie: movie)
        let vc = MovieDescriptionViewController(viewModel: vm)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}


// Make UI
extension MovieDescriptionViewController {
    func makeUI() {
        navigationItem.largeTitleDisplayMode = .never
        
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        scrollView.snp.makeConstraints {
            if #available(iOS 11, *) {
                $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            } else {
                $0.top.top.equalTo(topLayoutGuide.snp.top)
                $0.bottom.equalTo(bottomLayoutGuide.snp.bottom)
            }
            $0.left.right.equalToSuperview()
        }
        
        [posterImageView, yearLabel, genresLabel, descriptionTitleLabel, descriptionLabel, videosTitleLabel, videosCollectionView, similarMoviesTitleLabel, similarMoviesCollectionView].forEach {
            containerView.addSubview($0)
        }
        
        posterImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.3)
        }
        
        yearLabel.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.bottom).offset(15)
            $0.left.equalToSuperview().offset(15)
            $0.right.equalToSuperview().offset(-15)
        }
        
        genresLabel.snp.makeConstraints {
            $0.top.equalTo(yearLabel.snp.bottom).offset(5)
            $0.left.equalToSuperview().offset(15)
            $0.right.equalToSuperview().offset(-15)
        }
        
        descriptionTitleLabel.snp.makeConstraints {
            $0.top.equalTo(genresLabel.snp.bottom).offset(15)
            $0.left.equalToSuperview().offset(15)
            $0.right.equalToSuperview().offset(-15)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionTitleLabel.snp.bottom).offset(5)
            $0.left.equalToSuperview().offset(15)
            $0.right.equalToSuperview().offset(-15)
        }
        
        videosTitleLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            $0.left.equalTo(15)
            $0.right.equalTo(-15)
        }
        
        videosCollectionView.snp.makeConstraints {
            $0.top.equalTo(videosTitleLabel.snp.bottom).offset(10)
            $0.left.equalTo(15)
            $0.right.equalTo(-15)
            $0.height.equalTo(150)
        }
        
        similarMoviesTitleLabel.snp.makeConstraints {
            $0.top.equalTo(videosCollectionView.snp.bottom).offset(25)
            $0.left.equalTo(15)
            $0.right.equalTo(-15)
        }
        
        similarMoviesCollectionView.snp.makeConstraints {
            $0.top.equalTo(similarMoviesTitleLabel.snp.bottom).offset(10)
            $0.left.equalTo(15)
            $0.right.equalTo(-15)
            $0.height.equalTo(200)
        }
    }
}

