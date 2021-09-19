//
//  NewsFeedTableViewCell.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 13.05.2021.
//

import UIKit
import Kingfisher

final class AuthorOfFeedTableViewCell: UITableViewCell {
    
    //MARK:- Public properties
    static let reuseId = "AuthorOfFeedTableViewCell"
    
    //MARK:- Private properties
    private let authorPhotoImageView = UIImageView()
    private let authorNameLable = UILabel()
    private let dateOfPublicationLabel = UILabel()
    
    //MARK:- Life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: AuthorOfFeedTableViewCell.reuseId)
        setViews()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Public methods
    func config (authorName name: String, authorPhoto photo: String, dateOfPublication date: Int) {
        authorNameLable.text = name
        guard let url = URL(string: photo) else {return}
        authorPhotoImageView.kf.setImage(with: url)
        let timeInterval = TimeInterval(date)
        let trueDate = Date(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        dateOfPublicationLabel.text = dateFormatter.string(from: trueDate)
    }
    
    //MARK:- Private methods
    private func setViews() {
        self.addSubview(authorPhotoImageView)
        authorPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate ([
            authorPhotoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            authorPhotoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            authorPhotoImageView.widthAnchor.constraint(equalToConstant: 50),
            authorPhotoImageView.heightAnchor.constraint(equalToConstant: 50),
            authorPhotoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        ])
        authorPhotoImageView.layer.cornerRadius = 25
        authorPhotoImageView.layer.masksToBounds = true
        
        self.addSubview(authorNameLable)
        authorNameLable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            authorNameLable.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            authorNameLable.leadingAnchor.constraint(equalTo: authorPhotoImageView.trailingAnchor, constant: 20),
            authorNameLable.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
        authorNameLable.numberOfLines = 1
        authorNameLable.font = UIFont(name: authorNameLable.font.fontName, size: 25)
        authorNameLable.font = UIFont.boldSystemFont(ofSize: 16.0)
        authorNameLable.lineBreakMode = .byWordWrapping
        
        self.addSubview(dateOfPublicationLabel)
        dateOfPublicationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateOfPublicationLabel.topAnchor.constraint(equalTo: authorNameLable.bottomAnchor, constant: 6),
            dateOfPublicationLabel.leadingAnchor.constraint(equalTo: authorPhotoImageView.trailingAnchor, constant: 20),
            dateOfPublicationLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
        dateOfPublicationLabel.numberOfLines = 1
        dateOfPublicationLabel.font = UIFont(name: dateOfPublicationLabel.font.fontName, size: 13)
        dateOfPublicationLabel.textColor = .systemGray
        dateOfPublicationLabel.lineBreakMode = .byWordWrapping
    }
    
}
