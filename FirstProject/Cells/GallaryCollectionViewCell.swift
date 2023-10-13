//
//  GallaryCollectionViewCell.swift
//  FirstProject
//
//  Created by Софья Куликова on 02.10.2023.
//

import UIKit

class GallaryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var photoImageView: UIImageView!
    
    
    
    func setUp(photo: Photos){
        photoImageView.image = photo.image
        photoImageView.layer.cornerRadius = 10
        photoImageView.layer.masksToBounds = true
    }
    
}
