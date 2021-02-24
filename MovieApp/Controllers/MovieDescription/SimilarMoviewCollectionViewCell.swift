//
//  SimilarMoviewCollectionViewCell.swift
//  MovieApp
//
//  Created by Zhangir Tastemir on 5/8/20.
//  Copyright © 2020 Akysh Akan. All rights reserved.
//

import UIKit

class SimilarMoviewCollectionViewCell: UICollectionViewCell {
    
    enum Constants {
        static let url = "https://image.tmdb.org/t/p/w780/"
    }
    
    var movie: Movie? {
        didSet {
            if let posterPath = movie?.backdropPath, let imageUrl = URL(string: Constants.url)?.appendingPathComponent(posterPath) {
                imageView.af_setImage(withURL: imageUrl)
            }
            
            titleLabel.text = movie?.title
            yearLabel.text = String(movie?.releaseDate?.prefix(4) ?? "")
        }
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .lightGray
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let yearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SimilarMoviewCollectionViewCell {
    func makeUI() {
        [imageView, titleLabel, yearLabel].forEach {
            contentView.addSubview($0)
        }
        
        imageView.snp.makeConstraints {
            $0.left.top.right.equalToSuperview()
            $0.height.equalTo(150)
        }
        
        yearLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(10)
            $0.right.equalToSuperview()
            $0.width.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(10)
            $0.left.equalToSuperview()
            $0.right.equalTo(yearLabel.snp.left).offset(-10)
            $0.height.lessThanOrEqualTo(40)
        }
    }
}
