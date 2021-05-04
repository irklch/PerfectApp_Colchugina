//
//  FriendsTableViewCell.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 02.05.2021.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {
    
    
    let nameLabel = UILabel()
    let photoImageView = UIImageView()
    let shadowView = UIView()
    static var reuseId = "FriendsTableViewCell"
    
    @IBInspectable var shadowColor: UIColor = .black {
        didSet {
            self.updateShadowColor()
        }
    }
    @IBInspectable var shadowOpacity: Float = 0.4 {
        didSet {
            self.updateShadowOpacity()
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 8 {
        didSet {
            self.updateShadowRadius()
        }
    }
    
    
    private func updateShadowColor() {
        shadowView.layer.shadowColor = shadowColor.cgColor
    }
    
    private func updateShadowOpacity() {
        shadowView.layer.shadowOpacity = shadowOpacity
    }
    private func updateShadowRadius() {
        shadowView.layer.shadowRadius = shadowRadius
    }
  
    
    func config (name: String, photo: String) {
        photoImageView.image = UIImage(named: photo)
        nameLabel.text = name
        //вопрос: Я создала imageView, задала ему констреинты, заполнила уже его фоткой, но фреймы (photoImageView.frame.height) у него 0.0 . ПОЧЕМУУУУУУУ?
        
        photoImageView.layer.cornerRadius = 25
        photoImageView.layer.masksToBounds = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //добавляем nameLabel и задаём констреинты
        let margins = self.layoutMarginsGuide
        self.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
            
        ])
        
        
        //добавляем вьюшку для тени и задаём констреинты
        self.addSubview(shadowView)
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shadowView.widthAnchor.constraint(equalToConstant: 50),
            shadowView.heightAnchor.constraint(equalToConstant: 50),
            shadowView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 7),
            shadowView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -7),
            shadowView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -46)
            
        ])
        
        //настройки самой тени
        self.updateShadowColor()
        self.updateShadowRadius()
        self.updateShadowOpacity()
        shadowView.layer.shadowOffset = CGSize.zero
        
        
        //добавляем photoImageView и задаём констреинты
        shadowView.addSubview(photoImageView)
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoImageView.widthAnchor.constraint(equalToConstant: 50),
            photoImageView.heightAnchor.constraint(equalToConstant: 50),
            photoImageView.topAnchor.constraint(equalTo: shadowView.topAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor)
            
        ])
        //подгоняем размер фото под вьюшку
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.clipsToBounds = true
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
}
