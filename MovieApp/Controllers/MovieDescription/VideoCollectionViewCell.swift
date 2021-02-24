//
//  VideoCollectionViewCell.swift
//  MovieApp
//
//  Created by Zhangir Tastemir on 5/6/20.
//  Copyright © 2020 Akysh Akan. All rights reserved.
//

import UIKit

class VideoCollectionViewCell: UICollectionViewCell {
    
    var video: Video? {
        didSet {
            if let key = video?.key,  let url = URL(string: "https://img.youtube.com/vi/\(String(key))/1.jpg") {
                imageView.af_setImage(withURL: url)
            }
        }
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .black
        return iv
    }()
    
    lazy var playVideoButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        let image = UIImage(systemName: "play.fill")
        button.imageView?.tintColor = UIColor.white
        button.setImage(image, for: .normal)
        button.layer.cornerRadius = 35
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension VideoCollectionViewCell {
    func makeUI() {
        [imageView, playVideoButton].forEach {
            contentView.addSubview($0)
        }
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        playVideoButton.snp.makeConstraints {
            $0.centerX.equalTo(imageView.snp.centerX)
            $0.centerY.equalTo(imageView.snp.centerY)
            $0.width.height.equalTo(70)
        }
        
    }
}
