//
//  FriendsTableViewCell.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 02.05.2021.
//

import UIKit
import Kingfisher

final class FriendsTableViewCell: UITableViewCell {
    
    //MARK:- Public properties
    
    static var reuseId = "FriendsTableViewCell"
    
    //MARK:- Private properies
    
    private let nameLabel = UILabel()
    private let photoImageView = UIImageView()
    private let shadowView = UIView()
    
    @IBInspectable private var shadowColor: UIColor = .black {
        didSet {
            self.updateShadowColor()
        }
    }
    @IBInspectable private var shadowOpacity: Float = 0.4 {
        didSet {
            self.updateShadowOpacity()
        }
    }
    
    @IBInspectable private var shadowRadius: CGFloat = 8 {
        didSet {
            self.updateShadowRadius()
        }
    }
    //MARK:- Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setViews()
    }
    
    //MARK:- Public properties
    func config (firstName: String, lastName: String, photo: String) {
        guard let url = URL(string: photo) else {return}
        photoImageView.kf.setImage(with: url)
        nameLabel.text = ("\(lastName) \(firstName)")
    }
    
    //MARK:- Private methods
    
    private func updateShadowColor() {
        shadowView.layer.shadowColor = shadowColor.cgColor
    }
    
    private func updateShadowOpacity() {
        shadowView.layer.shadowOpacity = shadowOpacity
    }

    private func updateShadowRadius() {
        shadowView.layer.shadowRadius = shadowRadius
    }
    
    private func setViews() {
        
        //добавить nameLabel и задаём констреинты
        self.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor)
        ])
        
        //добавить вьюшку для тени и задать констреинты
        self.addSubview(shadowView)
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shadowView.widthAnchor.constraint(equalToConstant: 50),
            shadowView.heightAnchor.constraint(equalToConstant: 50),
            shadowView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            shadowView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -15),
            shadowView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        //настроить тень
        self.updateShadowColor()
        self.updateShadowRadius()
        self.updateShadowOpacity()
        shadowView.layer.shadowOffset = CGSize.zero
        
        //добавить photoImageView и задать констреинты
        shadowView.addSubview(photoImageView)
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoImageView.widthAnchor.constraint(equalToConstant: 50),
            photoImageView.heightAnchor.constraint(equalToConstant: 50),
            photoImageView.topAnchor.constraint(equalTo: shadowView.topAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor)
        ])
        
        //подогнать размер фото под вьюшку
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.clipsToBounds = true
        photoImageView.layer.cornerRadius = 25
        photoImageView.layer.masksToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
