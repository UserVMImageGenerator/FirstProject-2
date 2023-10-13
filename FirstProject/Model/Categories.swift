//
//  StructCollectionView.swift
//  FirstProject
//
//  Created by Софья Куликова on 06.09.2023.
//

import Foundation
import UIKit


struct Photo{
    var name: String
    var image: UIImage
    
    
    static func fetchPhoto() -> [Photo]{
        
        var pthotos: [Photo] = []
        
        if let image1 = UIImage(named: "regdcbsx"){
            let firstPhoto = Photo(name: "Avocado", image: image1)
            pthotos.append(firstPhoto)
        }
        if let image2 = UIImage(named: "93216"){
            let secondPhoto = Photo(name: "regdcbsx", image: image2)
            pthotos.append(secondPhoto)
        }
        if let image3 = UIImage(named: "vivid-blurred-colorful-background"){
            let thirdPhoto = Photo(name: "student", image: image3)
            pthotos.append(thirdPhoto)
        }
        if let image4 = UIImage(named: "avocado"){
            let thithPhoto = Photo(name: "student", image: image4)
            pthotos.append(thithPhoto)
        }
        if let image5 = UIImage(named: "pngwing.com-4"){
            let fithPhoto = Photo(name: "student", image: image5)
            pthotos.append(fithPhoto)
        }
        if let image6 = UIImage(named: "pngwing.com-5"){
            let sixPhoto = Photo(name:"student", image: image6)
            pthotos.append(sixPhoto)
        }
        if let image7 = UIImage(named:"pngwing.com-5"){
            let sevenPhoto = Photo(name: "student", image: image7)
            pthotos.append(sevenPhoto)
        }
       
        
        
        return pthotos
    }
    
}
struct Constant{
        static let leftDistanceToView: CGFloat = 25
        static let galleryMinLineSpacing: CGFloat = 15
        
    }
