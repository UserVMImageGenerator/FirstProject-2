//
//  CollectionViewCell.swift
//  FirstProject
//
//  Created by Софья Куликова on 06.09.2023.
//

import Foundation
import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "Cell"
    
    let mainImageView: UIImageView = {
        var view = UIImageView()
        view.frame = CGRect(x: 0, y: 0, width: 118, height: 118)
        view.layer.backgroundColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 0.2).cgColor
        view.layer.cornerRadius = 14
        view.clipsToBounds = true
        return view
    }()
    
    let  nameLabel: UILabel  = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 38, height: 15)
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var textView: UIView = {
        let text = UIView()
        text.frame = CGRect(x: 0, y: 0, width: 62, height: 23)
        text.layer.backgroundColor = UIColor(red: 0.062, green: 0.062, blue: 0.062, alpha: 0.3).cgColor
        text.layer.cornerRadius = 7
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(mainImageView)
        addSubview(nameLabel)
        mainImageView.addSubview(textView)

        
        
        NSLayoutConstraint.activate([
         
            mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainImageView.topAnchor.constraint(equalTo: topAnchor),
            mainImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 15),
            textView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 89 ),

            nameLabel.leadingAnchor.constraint(equalTo: textView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: textView.trailingAnchor),
            nameLabel.topAnchor.constraint(equalTo: textView.topAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: textView.bottomAnchor)
        ])

      
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
