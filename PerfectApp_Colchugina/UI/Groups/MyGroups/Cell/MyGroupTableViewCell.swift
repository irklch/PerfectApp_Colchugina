//
//  GroupTableViewCell.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 02.05.2021.
//

import UIKit

class MyGroupTableViewCell: UITableViewCell {
    @IBOutlet var groupNameLabel: UILabel!
    @IBOutlet var groupPhotoImageView: UIImageView!
    
    static var reuseId = "MyGroupTableViewCell"
    func config (name: String, photo: String) {
        groupNameLabel.text = name
        groupPhotoImageView.image = UIImage(named: photo)
       
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        groupPhotoImageView.layer.cornerRadius = CGFloat(10)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        animatePhoto()
    }
    
    func animatePhoto () {
        
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

}
