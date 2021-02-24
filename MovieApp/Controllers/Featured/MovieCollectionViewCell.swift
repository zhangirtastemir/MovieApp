
//  MovieCollectionViewCell.swift
//  MovieApp
//
//  Created by Zhangir Tastemir on 3/9/20.
//  Copyright © 2020 Akysh Akan. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieCollectionViewCell: UICollectionViewCell {
    
    enum Constants {
        static let url = "https://image.tmdb.org/t/p/w780/"
    }
    
    private let imageView: UIImageView = {
        var iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 10
        iv.clipsToBounds = true
        iv.backgroundColor = .black
        return iv
    }()
    
    private let titleLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 1
        return label
    }()
    
    private let yearLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .darkGray
        return label
    }()
    
    private let starImageView: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(systemName: "star.fill")
        image.tintColor = #colorLiteral(red: 0.002061008476, green: 0.8217948079, blue: 0.465944171, alpha: 1)
        return image
    }()
    
    private let averageVoteLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .darkGray
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(movie: Movie) {
        titleLabel.text = movie.title
        yearLabel.text = String((movie.releaseDate?.prefix(4))!)
        averageVoteLabel.text = String(movie.averageVote!)
        if let posterPath = movie.posterPath, let imageUrl = URL(string: Constants.url)?.appendingPathComponent(posterPath) {
            imageView.af_setImage(withURL: imageUrl)
        }
    }
}

// MARK: - UI
extension MovieCollectionViewCell {
    func makeUI() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(yearLabel)
        contentView.addSubview(averageVoteLabel)
        contentView.addSubview(starImageView)
        
        imageView.snp.makeConstraints {
            $0.height.equalTo(170)
            $0.top.left.right.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(10)
            $0.left.equalToSuperview().offset(5)
            $0.right.equalToSuperview()
        }
        
        yearLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(5)
            $0.top.equalTo(titleLabel.snp.bottom).offset(2)
            $0.width.equalTo(75)
        }
        
        starImageView.snp.makeConstraints {
            $0.right.equalTo(averageVoteLabel.snp.left).offset(-3)
            $0.top.equalTo(titleLabel.snp.bottom).offset(2)
            $0.height.width.equalTo(13)
        }
        
        averageVoteLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(2)
            $0.right.equalToSuperview()
            $0.width.equalTo(19)
        }
        
    }
}
