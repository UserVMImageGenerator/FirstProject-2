//
//  SettingsTableViewCell.swift
//  FirstProject
//
//  Created by Софья Куликова on 03.10.2023.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet var settingsView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var mainImageView: UIImageView!
    static let identifire = "SettingsTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "SettingsTableViewCell", bundle: nil)
    }
    
    public func configure( texts: String, image: UIImage){

        mainImageView.image = image
        titleLabel.text = texts
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
