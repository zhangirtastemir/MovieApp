//
//  VideosCollectionView.swift
//  MovieApp
//
//  Created by Zhangir Tastemir on 5/6/20.
//  Copyright © 2020 Akysh Akan. All rights reserved.
//

import UIKit

protocol VideosCollectionViewDelegate: class {
    func playVideo(key: String)
}

class VideosCollectionView: UICollectionView {
    
    enum Constants {
        static let cellId = "videoCell"
    }
    
    weak var videoDelegate: VideosCollectionViewDelegate?
    
    var videos: [Video] = []

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        backgroundColor = .white
        delegate = self
        dataSource = self
        register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: Constants.cellId)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func playVideoButtonTapped(_ sender: UIButton) {
        let video = videos[sender.tag]
        videoDelegate?.playVideo(key: video.key)
    }
    
}

extension VideosCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellId, for: indexPath) as! VideoCollectionViewCell
        cell.video = videos[indexPath.row]
        cell.playVideoButton.tag = indexPath.row
        cell.playVideoButton.addTarget(self, action: #selector(playVideoButtonTapped), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.size.width / 1.4, height: frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
}
