//
//  TextOfFeedTableViewCell.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 12.09.2021.
//

import UIKit

final class TextOfFeedTableViewCell: UITableViewCell {
    
    //MARK: - Public properties
    static let reuseId = "TextOfFeedTableViewCell"
    
    //MARK: - Private properties
    private let textOfFeedLabel = UILabel()
    
    //MARK: - Life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: TextOfFeedTableViewCell.reuseId)
        setViews()
    }
    
    @available(*,unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public methods
    func config(textOfFeed text: String, isTappedShowMore: Bool) {

        if text.count > 200 && text != "" {
            if isTappedShowMore {
                let newString = text + " Show Less"
                let lessString = "Show Less"
                let range = (newString as NSString).range(of: lessString)
                let mutableAttributedString = NSMutableAttributedString.init(string: String(newString))
                mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: range)
                textOfFeedLabel.attributedText = mutableAttributedString
            } else {
                let droppedString = text.dropLast(text.count - 200) + "... Show More"
                let moreString = "Show More"
                let range = (droppedString as NSString).range(of: moreString)
                let mutableAttributedString = NSMutableAttributedString.init(string: String(droppedString))
                mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: range)
                textOfFeedLabel.attributedText = mutableAttributedString
            }
        }
        else {
            textOfFeedLabel.text = text
        }
    }
    
    //MARK: - Private pethods
    private func setViews() {
        self.addSubview(textOfFeedLabel)
        textOfFeedLabel.translatesAutoresizingMaskIntoConstraints = false
        textOfFeedLabel.sizeToFit()
        textOfFeedLabel.adjustsFontSizeToFitWidth = true
        textOfFeedLabel.minimumScaleFactor = 0.5
        textOfFeedLabel.numberOfLines = 0
        textOfFeedLabel.backgroundColor = .white
        NSLayoutConstraint.activate([
            textOfFeedLabel.topAnchor.constraint(equalTo: self.topAnchor),
            textOfFeedLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            textOfFeedLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            textOfFeedLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ])
    }
    
}
