//
//  LikeControl.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 04.05.2021.
//

import UIKit

class LikeControl: UIControl {

    //MARK: - Private properties
    private let likeCountLabel = UILabel()
    private let likeButton = UIButton(type: .system)
    private var isToggled: Bool = false
    private var likeCount: Int = Int.random(in: 1...1000)

    //MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    //MARK: - Private methods
    private func setViews() {

        //        self.addTarget(self, action: #selector(tapToLike(_:)), for: .touchUpInside)

        self.addSubview(likeButton)
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            likeButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            likeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50)
        ])
        likeButton.setImage(UIImage.init(systemName: "suit.heart"), for: .normal)
        likeButton.tintColor = .systemGray
//        likeButton.backgroundColor = .white
        likeButton.addTarget(self, action: #selector(tapToLike(_:)), for: .touchUpInside)

        self.addSubview(likeCountLabel)
        likeCountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            likeCountLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            likeCountLabel.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 5)
        ])
        likeCountLabel.tintColor = .systemGray
//        likeCountLabel.backgroundColor = .white
        likeCountLabel.text = "\(likeCount)"
    }

    @objc private func tapToLike(_ button: UIButton) {
        isToggled.toggle()
        likeButton.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)

        if isToggled {
            UIView.animate(
                withDuration: 1,
                delay: 0,
                usingSpringWithDamping: 1,
                initialSpringVelocity: 0.5,
                options: .curveEaseInOut,
                animations: {
                    self.likeButton.transform = .identity
                    self.likeButton.setImage(UIImage.init(systemName: "suit.heart.fill"), for: .normal)
                    self.likeButton.tintColor = .red
                    self.likeCountLabel.textColor = .red
                    self.likeCountLabel.text = "\(self.likeCount + 1)"
                },
                completion: nil)
        } else {
            UIView.animate(
                withDuration: 1,
                delay: 0,
                usingSpringWithDamping: 1,
                initialSpringVelocity: 0.5,
                options: .curveEaseInOut,
                animations: {
                    self.likeButton.transform = .identity
                    self.likeButton.setImage(UIImage.init(systemName: "suit.heart"), for: .normal)
                    self.likeButton.tintColor = .systemGray
                    self.likeCountLabel.textColor = .systemGray
                    self.likeCountLabel.text = "\(self.likeCount)"
                },
                completion: nil)
        }
    }

}
