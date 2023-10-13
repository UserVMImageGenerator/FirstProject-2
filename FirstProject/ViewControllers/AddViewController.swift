//
//  AddViewController.swift
//  FirstProject
//
//  Created by Софья Куликова on 03.10.2023.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet var generateImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    let photoPicker = PhotoPicker()
    
    @IBAction func addButton(_ sender: Any) {
        
        photoPicker.showImagePicker(in: self){ imge in
            self.generateImageView.image = imge
            
            
            
        }
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: .zero, size: newSize)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
   
    
//    @IBAction func loadFaceButton(_ sender: Any) {
//        
//        if let newImage = generateImageView.image, let resizedImage = self.resizeImage(image:newImage, targetSize: CGSize(width: 893, height: 1038)) {
//            VisionRequester().detectFace(inputImage: resizedImage) { image in
//                self.generateImageView.image = image
//                
//              
//                
//                
//                APIServiceAI().generateEditedImage(from:  resizedImage, with: image!) { url in
//                    if let url = url {
//                        self.downloadImage(for: url) { image in
//                            self.generateImageView.image = image
//
//                            
//                            
//                            APIServiceAI().generateImageVariation(from: image!) { url in
//                                self.downloadImage(for: url!) { image  in
//                                    self.generateImageView.image
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    }
}
