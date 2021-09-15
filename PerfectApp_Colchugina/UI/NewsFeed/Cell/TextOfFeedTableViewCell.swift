//
//  TextOfFeedTableViewCell.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 12.09.2021.
//

import UIKit

final class TextOfFeedTableViewCell: UITableViewCell {
    
    //MARK:- Public properties
    static let reuseId = "TextOfFeedTableViewCell"
    
    //MARK:- Private properties
    private let textOfFeedLabel = UILabel()
    
    //MARK:- Life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: TextOfFeedTableViewCell.reuseId)
        setViews()
    }
    
    @available(*,unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Public methods
    func config(textOfFeed text: String) {
        textOfFeedLabel.text = text
    }
    
    //MARK:- Private pethods
    private func setViews() {
        self.addSubview(textOfFeedLabel)
        textOfFeedLabel.translatesAutoresizingMaskIntoConstraints = false
        textOfFeedLabel.sizeToFit()
        textOfFeedLabel.adjustsFontSizeToFitWidth = true
        textOfFeedLabel.minimumScaleFactor = 0.5
        textOfFeedLabel.numberOfLines = 0
        NSLayoutConstraint.activate([
            textOfFeedLabel.topAnchor.constraint(equalTo: self.topAnchor),
            textOfFeedLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            textOfFeedLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            textOfFeedLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ])
    }
    
}
