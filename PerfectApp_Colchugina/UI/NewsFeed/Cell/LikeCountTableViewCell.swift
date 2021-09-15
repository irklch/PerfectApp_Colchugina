//
//  LikeCountTableViewCell.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 12.09.2021.
//

import UIKit

final class LikeCountTableViewCell: UITableViewCell {
    
    //MARK:- Public properties
    
    let likeButton = UIButton(type: .system)
    static let reuseId = "LikeCountTableViewCell"
    
    //MARK:- Private properties
    
    private let commentButton = UIButton(type: .system)
    private let shareButton = UIButton(type: .system)
    private let viewsButton = UIButton(type: .system)
    
    //MARK:- Life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: LikeCountTableViewCell.reuseId)
        setViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Public methods
    
    func config(likeCount likes: Int, commentCount comment: Int, shareCount share: Int, viewsCont views: Int) {
        likeButton.setTitle("\(likes)", for: .normal)
        commentButton.setTitle("\(comment)", for: .normal)
        shareButton.setTitle("\(share)", for: .normal)
        viewsButton.setTitle("\(views)", for: .normal)
    }
    
    //MARK:- Private methods
    
    private func setViews() {
        self.addSubview(likeButton)
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            likeButton.topAnchor.constraint(equalTo: self.topAnchor),
            likeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            likeButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            likeButton.heightAnchor.constraint(equalToConstant: 18)
        ])
        likeButton.setImage(UIImage.init(systemName: "suit.heart"), for: .normal)
        likeButton.tintColor = .systemGray
        likeButton.titleEdgeInsets.right = -7
        
        self.addSubview(commentButton)
        commentButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            commentButton.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor),
            commentButton.leadingAnchor.constraint(equalTo: likeButton.leadingAnchor, constant: 60),
            commentButton.heightAnchor.constraint(equalToConstant: 18)
        ])
        commentButton.setImage(UIImage.init(systemName: "message"), for: .normal)
        commentButton.tintColor = .systemGray
        commentButton.titleEdgeInsets.right = -7
        
        self.addSubview(shareButton)
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shareButton.centerYAnchor.constraint(equalTo: commentButton.centerYAnchor),
            shareButton.leadingAnchor.constraint(equalTo: commentButton.leadingAnchor, constant: 60),
            shareButton.heightAnchor.constraint(equalToConstant: 18)
        ])
        shareButton.setImage(UIImage.init(systemName: "arrowshape.turn.up.right"), for: .normal)
        shareButton.tintColor = .systemGray
        shareButton.titleEdgeInsets.right = -7
        
        self.addSubview(viewsButton)
        viewsButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewsButton.centerYAnchor.constraint(equalTo: shareButton.centerYAnchor),
            viewsButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            viewsButton.heightAnchor.constraint(equalToConstant: 18)
        ])
        viewsButton.setImage(UIImage.init(systemName: "eye"), for: .normal)
        viewsButton.tintColor = .systemGray
        viewsButton.imageEdgeInsets.left = -7
    }
    
}
