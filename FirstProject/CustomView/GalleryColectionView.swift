//
//  GalleryColectionView.swift
//  FirstProject
//
//  Created by Софья Куликова on 06.09.2023.
//

import Foundation
import UIKit

class GalleryCollectionView: UICollectionView, UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
    var cells = [Photo]()

    init(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        
        backgroundColor = .clear
        
        delegate = self
        dataSource = self
        register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseId)
        translatesAutoresizingMaskIntoConstraints = false
        layout.minimumLineSpacing = Constant.galleryMinLineSpacing
        contentInset = UIEdgeInsets(top: 0, left: Constant.leftDistanceToView, bottom: 0, right: 0)
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        
    
        
    }
    
    func set(cells: [Photo]){
        self.cells = cells
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseId, for: indexPath) as? CollectionViewCell
        cell?.mainImageView.image = cells[indexPath.row].image
        
        cell?.nameLabel.text = cells[indexPath.row].name
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 118, height: 118)
    }
    
}
