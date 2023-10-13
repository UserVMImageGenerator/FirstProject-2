//
//  GenerateViewController.swift
//  FirstProject
//
//  Created by Софья Куликова on 02.10.2023.
//

import UIKit

class GenerateViewController: UIViewController {

    @IBOutlet var shareButton: UIButton!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var image: UIImageView!
    
    var generatedImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        saveButton.layer.cornerRadius = 25
        saveButton.clipsToBounds = true
        saveButton.layer.masksToBounds = true
        
        
        shareButton.layer.cornerRadius = 25
        shareButton.clipsToBounds = true
        shareButton.layer.masksToBounds = true
        
        image.image = generatedImage
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
       
        
    }
    

  

}
