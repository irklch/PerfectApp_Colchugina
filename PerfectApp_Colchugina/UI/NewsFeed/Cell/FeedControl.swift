//
//  FeedControl.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 14.05.2021.
//

import UIKit

class FeedControl: UIControl {
    
    var feedIndex = Int()
    var likeImageView = UIButton(type: .system)
    var likeCountLabel = UILabel()
    var commentImageView = UIButton(type: .system)
    var commentCountLabel = UILabel()
    var shareImageView = UIButton(type: .system)
    var shareCountLabel = UILabel()
    var viewImageView = UIButton(type: .system)
    var viewCountLabel = UILabel()
    
    var isLikeToggled: Bool = false
    
    private func setViews() {
        
        
        likeImageView.setImage(UIImage.init(systemName: "suit.heart"), for: .normal)
        likeImageView.tintColor = .systemGray
        likeImageView.addTarget(self, action: #selector(tapToLike(_:)), for: .touchUpInside)
        
        
        self.addSubview(likeImageView)
        likeImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            likeImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            likeImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            likeImageView.widthAnchor.constraint(equalToConstant: 25),
            likeImageView.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        likeCountLabel.tintColor = .gray
        self.addSubview(likeCountLabel)
        likeCountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            likeCountLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            likeCountLabel.leadingAnchor.constraint(equalTo: likeImageView.trailingAnchor, constant: 10)
        ])
        
        commentImageView.setImage(UIImage.init(systemName: "message"), for: .normal)
        commentImageView.tintColor = .systemGray
        self.addSubview(commentImageView)
        commentImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            commentImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            commentImageView.leadingAnchor.constraint(equalTo: likeCountLabel.leadingAnchor, constant: 40),
            commentImageView.widthAnchor.constraint(equalToConstant: 25),
            commentImageView.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        commentCountLabel.tintColor = .systemGray
        self.addSubview(commentCountLabel)
        commentCountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            commentCountLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            commentCountLabel.leadingAnchor.constraint(equalTo: commentImageView.trailingAnchor, constant: 10)
        ])
        
        
        shareImageView.setImage(UIImage.init(systemName: "arrowshape.turn.up.right"), for: .normal)
        shareImageView.tintColor = .systemGray
        self.addSubview(shareImageView)
        shareImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shareImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            shareImageView.leadingAnchor.constraint(equalTo: commentCountLabel.leadingAnchor, constant: 40),
            shareImageView.widthAnchor.constraint(equalToConstant: 25),
            shareImageView.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        shareCountLabel.tintColor = .systemGray
        self.addSubview(shareCountLabel)
        shareCountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shareCountLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            shareCountLabel.leadingAnchor.constraint(equalTo: shareImageView.trailingAnchor, constant: 10)
        ])
        
        viewCountLabel.tintColor = .systemGray
        self.addSubview(viewCountLabel)
        viewCountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewCountLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            viewCountLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0)
        ])
        
        viewImageView.setImage(UIImage.init(systemName: "eye"), for: .normal)
        viewImageView.tintColor = .systemGray
        self.addSubview(viewImageView)
        viewImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            viewImageView.trailingAnchor.constraint(equalTo: viewCountLabel.leadingAnchor, constant: -10),
            viewImageView.widthAnchor.constraint(equalToConstant: 25),
            viewImageView.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        
    }
    
    func config (_ likeCount: Int, _ commentCount: Int, _ shareCount: Int, _ viewCount: Int, _ feedId: Int) {
        likeCountLabel.text = "\(likeCount)"
        commentCountLabel.text = "\(commentCount)"
        shareCountLabel.text = "\(shareCount)"
        viewCountLabel.text = "\(viewCount)"
        feedIndex = feedId
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setViews()
    }
    
    
    
    @objc func tapToLike(_ button: UIButton) {
        isLikeToggled.toggle()
        
        // нажимаю на лайк один раз, а лайкаются сразу 3 поста. Почему?
            if isLikeToggled {
                likeImageView.setImage(UIImage.init(systemName: "suit.heart.fill"), for: .normal)
                NewsFeed.list[feedIndex].likeCount += 1
                likeCountLabel.text = "\(NewsFeed.list[feedIndex].likeCount)"
                likeImageView.tintColor = .red
                likeCountLabel.textColor = .red
            } else {
                likeImageView.setImage(UIImage.init(systemName: "suit.heart"), for: .normal)
                likeImageView.tintColor = .systemGray
                likeCountLabel.textColor = .systemGray
                NewsFeed.list[feedIndex].likeCount -= 1
                likeCountLabel.text = "\(NewsFeed.list[feedIndex].likeCount)"
            }
        
    }
    
   
}


