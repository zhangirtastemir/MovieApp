//
//  SearchTableViewCell.swift
//  MovieApp
//
//  Created by Zhangir Tastemir on 5/8/20.
//  Copyright © 2020 Akysh Akan. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    enum Constants {
        static let url = "https://image.tmdb.org/t/p/w780/"
    }
    
    var movie: Movie? {
        didSet {
            if let posterPath = movie?.posterPath, let imageUrl = URL(string: Constants.url)?.appendingPathComponent(posterPath) {
                movieImageView.af_setImage(withURL: imageUrl)
            }
            
            movieTitleLabel.text = movie?.title
            movieYearLabel.text = String((movie?.releaseDate?.prefix(4)) ?? "")
        }
    }
    
    let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    let movieYearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.gray
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// make UI
extension SearchTableViewCell {
    func makeUI() {
        [movieImageView, movieTitleLabel, movieYearLabel].forEach {
            contentView.addSubview($0)
        }
        
        movieImageView.snp.makeConstraints {
            $0.top.left.equalToSuperview().offset(15)
            $0.bottom.equalToSuperview().offset(-10)
            $0.width.equalTo(100)
            $0.height.equalTo(140)
        }
        
        movieTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.left.equalTo(movieImageView.snp.right).offset(15)
            $0.right.equalToSuperview().offset(-10)
        }
        
        movieYearLabel.snp.makeConstraints {
            $0.top.equalTo(movieTitleLabel.snp.bottom).offset(5)
            $0.left.equalTo(movieImageView.snp.right).offset(15)
            $0.right.equalToSuperview().offset(-10)
        }
    }
}
