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
    buttonLike.tintColor = .black
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
    

    if isToggled {
        likeCountLabel.text = "\(likeCount + 1)"
        buttonLike.setImage(UIImage.init(systemName: "suit.heart.fill"), for: .normal)
        buttonLike.tintColor = .red
        likeCountLabel.textColor = .red
    } else {
        buttonLike.setImage(UIImage.init(systemName: "suit.heart"), for: .normal)
        likeCountLabel.text = "\(likeCount)"
        buttonLike.tintColor = .black
        likeCountLabel.textColor = .black
    }
   
}
}
