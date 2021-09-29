//
//  PhotoOfFeedTableViewCell.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 12.09.2021.
//

import UIKit
import Kingfisher

final class PhotoOfFeedTableViewCell: UITableViewCell {
    
    //MARK:- Public properties
    static let reuseId = "PhotoOfFeedTableViewCell"
    
    //MARK:- Private properties
    private let photoOfFeedImageView = UIImageView()
    
    //MARK:- Life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: PhotoOfFeedTableViewCell.reuseId)
        setViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Public methods
    func config(photoOfFeed photo: String) {
        guard let url = URL(string: photo) else {return}
        photoOfFeedImageView.kf.setImage(with: url)
    }
    
    //MARK:- Private methods
    private func setViews() {
        self.addSubview(photoOfFeedImageView)
        photoOfFeedImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoOfFeedImageView.heightAnchor.constraint(equalToConstant: 200),
            photoOfFeedImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            photoOfFeedImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            photoOfFeedImageView.topAnchor.constraint(equalTo: self.topAnchor),
            photoOfFeedImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ])
        photoOfFeedImageView.contentMode = .scaleAspectFit
    }
    
}
