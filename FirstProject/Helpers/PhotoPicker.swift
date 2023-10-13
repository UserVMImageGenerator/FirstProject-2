//
//  PhotoPicker.swift
//  FirstProject
//
//  Created by Софья Куликова on 13.09.2023.
//

import Foundation
import UIKit

class PhotoPicker: NSObject, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var imagePickerController: UIImagePickerController?
    
    var comletion: ((UIImage) -> ())?

    
    func showImagePicker(in viewController: UIViewController,  comletion: ((UIImage) -> ())?){
        self.comletion = comletion
        imagePickerController = UIImagePickerController()
        imagePickerController?.delegate = self
        viewController.present(imagePickerController!, animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage{
            self.comletion?(image)
            picker.dismiss(animated: true)
        }
    }
}
