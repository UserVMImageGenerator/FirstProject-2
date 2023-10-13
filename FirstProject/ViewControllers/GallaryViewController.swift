//
//  GallaryViewController.swift
//  FirstProject
//
//  Created by Софья Куликова on 02.10.2023.
//

import UIKit

class GallaryViewController: UIViewController {

    
    @IBOutlet var gallaryCollectionView: UICollectionView!
    
    @IBOutlet var mainStackView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
        
        gallaryCollectionView.dataSource = self
        gallaryCollectionView.delegate = self
        gallaryCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        gallaryCollectionView.backgroundColor = .clear
    }
    

 

}

extension GallaryViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     
        if images.isEmpty {
            gallaryCollectionView.isHidden = true
            return mainStackView as? Int ?? 0
        } else {
            gallaryCollectionView.isHidden = false

          return images.count
        }
   

       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = gallaryCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GallaryCollectionViewCell
        cell.setUp(photo: images[indexPath.row])
       
        return cell
    }

}


extension GallaryViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (gallaryCollectionView.frame.size.width - 10 ) / 2, height: (gallaryCollectionView.frame.size.width - 10 ) / 2)
    }
}
