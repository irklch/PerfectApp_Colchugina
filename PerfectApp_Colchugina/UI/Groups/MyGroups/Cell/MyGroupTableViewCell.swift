//
//  GroupTableViewCell.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 02.05.2021.
//

import UIKit

final class MyGroupTableViewCell: UITableViewCell {
    
    //MARK:- Public properties
    static var reuseId = "MyGroupTableViewCell"
    
    //MARK:- Private properties
    @IBOutlet private var groupNameLabel: UILabel!
    @IBOutlet private var groupPhotoImageView: UIImageView!
    
    //MARK:- Public methods
    func config (name: String, photo: String) {
        groupNameLabel.text = name
        guard let url = URL(string: photo) else {return}
        groupPhotoImageView.kf.setImage(with: url)
    }
    
    //MARK:- Private properties
    private func animatePhoto () {
        groupPhotoImageView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        UIView.animate(
            withDuration: 1,
            delay: 0,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 0.2,
            options: .curveEaseInOut,
            animations: {
                self.groupPhotoImageView.transform = .identity
            },
            completion: nil)
    }
    
    private func setCorneerRadious() {
        groupPhotoImageView.layer.cornerRadius = CGFloat(10)
    }
    
    
    //MARK:- Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setCorneerRadious()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        animatePhoto()
    }
}
