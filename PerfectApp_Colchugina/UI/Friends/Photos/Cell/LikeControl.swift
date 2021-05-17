//
//  LikeControl.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 04.05.2021.
//

import UIKit

class LikeControl: UIControl {
    let likeCountLabel = UILabel()
    let buttonLike = UIButton(type: .system)
    var isToggled: Bool = false
    var likeCount: Int = Int.random(in: 1...1000)
    
private func setViews() {
    
    buttonLike.setImage(UIImage.init(systemName: "suit.heart"), for: .normal)
    buttonLike.tintColor = .systemGray
    likeCountLabel.tintColor = .systemGray
    buttonLike.addTarget(self, action: #selector(tapToLike(_:)), for: .touchUpInside)
    self.addTarget(self, action: #selector(tapToLike(_:)), for: .touchUpInside)
    
    
    self.addSubview(buttonLike)
    buttonLike.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        buttonLike.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        buttonLike.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
    ])
    
    
    likeCountLabel.text = "\(likeCount)"
    self.addSubview(likeCountLabel)
    likeCountLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        likeCountLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        likeCountLabel.leadingAnchor.constraint(equalTo: buttonLike.trailingAnchor, constant: 5)
    ])
    
    
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
    isToggled.toggle()
    buttonLike.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)

    if isToggled {
        UIView.animate(
            withDuration: 1,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 0.5,
            options: .curveEaseInOut,
            animations: {
                self.buttonLike.transform = .identity
                self.buttonLike.setImage(UIImage.init(systemName: "suit.heart.fill"), for: .normal)
                self.buttonLike.tintColor = .red
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
                self.buttonLike.transform = .identity
                self.buttonLike.setImage(UIImage.init(systemName: "suit.heart"), for: .normal)
                self.buttonLike.tintColor = .systemGray
                self.likeCountLabel.textColor = .systemGray
                self.likeCountLabel.text = "\(self.likeCount)"
     },
            completion: nil)
        
        
    }
   
}
}
