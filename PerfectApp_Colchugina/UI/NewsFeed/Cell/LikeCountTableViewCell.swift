//
//  LikeCountTableViewCell.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 12.09.2021.
//

import UIKit

final class LikeCountTableViewCell: UITableViewCell {
    
    //MARK: - Public properties
    
    let likeButton = UIButton(type: .system)
    static let reuseId = "LikeCountTableViewCell"
    
    //MARK: - Private properties
    
    private var commentButton = UIButton(type: .system)
    private var shareButton = UIButton(type: .system)
    private var viewsButton = UIButton(type: .system)
    
    //MARK: - Life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: LikeCountTableViewCell.reuseId)
        setViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public methods
    
    func config(from viewModel: NewsCellViewModel, with indexPath: Int) {
        likeButton.tag = indexPath
        likeButton.setTitle("\(viewModel.likeButton)", for: .normal)
        commentButton.setTitle("\(viewModel.commentButton)", for: .normal)
        shareButton.setTitle("\(viewModel.shareButton)", for: .normal)
        viewsButton.setTitle("\(viewModel.viewsButton)", for: .normal)
        if viewModel.isLiked {
            likeButton.setImage(UIImage.init(systemName: "suit.heart.fill"), for: .normal)
            likeButton.tintColor = .red
        }
        else {
            likeButton.setImage(UIImage.init(systemName: "suit.heart"), for: .normal)
            likeButton.tintColor = .systemGray
        }
    }
    
    //MARK: - Private methods
    
    private func setViews() {
        contentView.addSubview(likeButton)
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            likeButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            likeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            likeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            likeButton.heightAnchor.constraint(equalToConstant: 18)
        ])
        likeButton.setImage(UIImage.init(systemName: "suit.heart"), for: .normal)
        likeButton.tintColor = .systemGray
        likeButton.titleEdgeInsets.right = -7
        likeButton.backgroundColor = .white
        
        contentView.addSubview(commentButton)
        commentButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            commentButton.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor),
            commentButton.leadingAnchor.constraint(equalTo: likeButton.leadingAnchor, constant: 60),
            commentButton.heightAnchor.constraint(equalToConstant: 18)
        ])
        commentButton.setImage(UIImage.init(systemName: "message"), for: .normal)
        commentButton.tintColor = .systemGray
        commentButton.titleEdgeInsets.right = -7
        commentButton.backgroundColor = .white
        
        contentView.addSubview(shareButton)
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shareButton.centerYAnchor.constraint(equalTo: commentButton.centerYAnchor),
            shareButton.leadingAnchor.constraint(equalTo: commentButton.leadingAnchor, constant: 60),
            shareButton.heightAnchor.constraint(equalToConstant: 18)
        ])
        shareButton.setImage(UIImage.init(systemName: "arrowshape.turn.up.right"), for: .normal)
        shareButton.tintColor = .systemGray
        shareButton.titleEdgeInsets.right = -7
        shareButton.backgroundColor = .white
        
        contentView.addSubview(viewsButton)
        viewsButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewsButton.centerYAnchor.constraint(equalTo: shareButton.centerYAnchor),
            viewsButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            viewsButton.heightAnchor.constraint(equalToConstant: 18)
        ])
        viewsButton.setImage(UIImage.init(systemName: "eye"), for: .normal)
        viewsButton.tintColor = .systemGray
        viewsButton.imageEdgeInsets.left = -7
        viewsButton.backgroundColor = .white
    }


    @objc
    private func tapToLike(_ button: UIButton) {
        if button.tintColor != .red {
            button.setImage(UIImage.init(systemName: "suit.heart.fill"), for: .normal)
            let count = Int(button.titleLabel?.text ?? "0") ?? 0 + 1
            button.setTitle("\(count)", for: .selected)
            button.tintColor = .red
        } else {
            button.setImage(UIImage.init(systemName: "suit.heart"), for: .normal)
            button.tintColor = .systemGray
            let count = Int(button.titleLabel?.text ?? "0") ?? 0 - 1
            button.setTitle("\(count)", for: .normal)
        }
    }
}
