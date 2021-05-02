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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
