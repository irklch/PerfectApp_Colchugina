//
//  FeedControl.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 14.05.2021.
//

import UIKit

class FeedControl: UIControl {
    
    var count = Int()
    var likeImageView = UIButton(type: .system)
    var likeCountLabel = UILabel()
    var commentImageView = UIButton(type: .system)
    var commentCountLabel = UILabel()
    var shareImageView = UIButton(type: .system)
    var shareCountLabel = UILabel()
    var viewImageView = UIButton(type: .system)
    var viewCountLabel = UILabel()
    
    
    
    var isLikeToggled: Bool = false
    var isCommentToggled: Bool = false
    var isShareToggled: Bool = false
    
    private func setViews() {
        
        
        likeImageView.setImage(UIImage.init(systemName: "suit.heart"), for: .normal)
        likeImageView.tintColor = .systemGray
//        likeImageView.addTarget(self, action: #selector(tapToLike(_:)), for: .touchUpInside)
        
        
        self.addSubview(likeImageView)
        likeImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            likeImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            likeImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            likeImageView.widthAnchor.constraint(equalToConstant: 25),
            likeImageView.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        likeCountLabel.tintColor = .systemGray
        likeCountLabel.text = "\(count)"
        self.addSubview(likeCountLabel)
        likeCountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            likeCountLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            likeCountLabel.leadingAnchor.constraint(equalTo: likeImageView.trailingAnchor, constant: 5)
        ])
        
        commentImageView.setImage(UIImage.init(systemName: "message"), for: .normal)
        commentImageView.tintColor = .systemGray
        self.addSubview(commentImageView)
        commentImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            commentImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            commentImageView.leadingAnchor.constraint(equalTo: likeCountLabel.leadingAnchor, constant: 20),
            commentImageView.widthAnchor.constraint(equalToConstant: 25),
            commentImageView.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        commentCountLabel.text = "0"
        commentCountLabel.tintColor = .systemGray
        self.addSubview(commentCountLabel)
        commentCountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            commentCountLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            commentCountLabel.leadingAnchor.constraint(equalTo: commentImageView.trailingAnchor, constant: 5)
        ])
        
        
        shareImageView.setImage(UIImage.init(systemName: "arrowshape.turn.up.right"), for: .normal)
        shareImageView.tintColor = .systemGray
        self.addSubview(shareImageView)
        shareImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shareImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            shareImageView.leadingAnchor.constraint(equalTo: commentCountLabel.leadingAnchor, constant: 20),
            shareImageView.widthAnchor.constraint(equalToConstant: 25),
            shareImageView.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        shareCountLabel.text = "0"
        shareCountLabel.tintColor = .systemGray
        self.addSubview(shareCountLabel)
        shareCountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shareCountLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            shareCountLabel.leadingAnchor.constraint(equalTo: shareImageView.trailingAnchor, constant: 5)
        ])
        
        viewCountLabel.text = "0"
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
            viewImageView.trailingAnchor.constraint(equalTo: viewCountLabel.leadingAnchor, constant: -5),
            viewImageView.widthAnchor.constraint(equalToConstant: 25),
            viewImageView.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        
    }
    
//     func configf (likeCount likeCount: Int, _ commentCount: Int, _ shareCount: Int, _ viewCount: Int) {
//        likeCountLabel.text = "\(likeCount)"
//        commentCountLabel.text = "\(commentCount)"
//        shareCountLabel.text = "\(commentCount)"
//        viewCountLabel.text = "\(viewCount)"
//    }
    func configf (_ countf: Int) {
        count = countf
   }

override init(frame: CGRect) {
    super.init(frame: frame)
    setViews()
}

required init?(coder: NSCoder) {
    super.init(coder: coder)
    setViews()
}



@objc func tapToLike(_ button: UIButton) {
    isLikeToggled.toggle()
    

//    if isLikeToggled {
//        likeCountLabel.text = "\(Int(likeCountLabel.text!)! + 1)"
//        likeImageView.image = UIImage(named: "suit.heart.fill")
//        likeImageView.tintColor = .red
//        likeCountLabel.textColor = .red
//    } else {
//        likeCountLabel.text = "\(Int(likeCountLabel.text!)!)"
//        likeImageView.image = UIImage(named: "suit.heart")
//        likeImageView.tintColor = .systemGray
//        likeCountLabel.textColor = .systemGray
//    }
   
}
}


