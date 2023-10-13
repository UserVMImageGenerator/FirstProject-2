//
//  FirstViewController.swift
//  FirstProject
//
//  Created by Софья Куликова on 07.10.2023.
//

import UIKit

class HomeViewController: UIViewController {

    private var  galleryCollectionView = GalleryCollectionView()
 
    @IBOutlet var scrollViewGallery: UIScrollView!
    
    @IBOutlet var imagePicker: UIImageView!
    
    @IBOutlet var textLabelSelect: UILabel!
    @IBOutlet var textLabelDescribe: UILabel!
    @IBOutlet var textLabelGenerator: UILabel!
    @IBOutlet var textView: UITextView!
    
    @IBOutlet var buttonGenerate: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTextView()
        
        
        scrollViewGallery.insetsLayoutMarginsFromSafeArea = false
        scrollViewGallery.contentInsetAdjustmentBehavior = .never
        
        //        view.insetsLayoutMarginsFromSafeArea = false
        
        view.addSubview(galleryCollectionView)
        galleryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        galleryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        galleryCollectionView.topAnchor.constraint(equalTo: textLabelSelect.bottomAnchor, constant: 30).isActive = true
        
        galleryCollectionView.heightAnchor.constraint(equalToConstant: 246).isActive = true
        
        galleryCollectionView.set(cells: Photo.fetchPhoto())
        
     //   buttonGenerate.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        textView.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    
    @objc func buttonAction(sender: UIButton!) {
        if let promptText = textView.text, promptText != "" {
            AppCoordinator.shared.showLoadingScreen(text: promptText)
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func generateButtonPressed(_ sender: UIButton) {
        if let promptText = textView.text, promptText != "" {
            AppCoordinator.shared.showLoadingScreen(text: promptText)
        }
    }
    
    func setUpTextView(){
       textView.backgroundColor = UIColor(red: 0.983, green: 0.933, blue: 1, alpha: 0.15)
        textView.layer.cornerRadius = 14
        textView.layer.borderWidth = 1
        textView.layer.borderColor = CGColor(red: 0.631, green: 0.145, blue: 0.647, alpha: 1)
      textView.layer.shadowColor = UIColor(red: 0.983, green: 0.933, blue: 1, alpha: 0.15).cgColor
        textView.layer.shadowOpacity = 1
        textView.layer.shadowRadius = 17
        textView.layer.shadowOffset = CGSize(width: 1, height: 1)
        textView.clipsToBounds = false
        
       
  
    }
    

    let photoPicker = PhotoPicker()
    @IBAction func buttonImagePicker(_ sender: Any) {
        
        photoPicker.showImagePicker(in: self){ imge in
            self.imagePicker.image = imge
        }
    }
    
}

extension HomeViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
