//
//  Model.swift
//  FirstProject
//
//  Created by Софья Куликова on 02.10.2023.
//

import Foundation

struct Response: Decodable{
    var data: [ImageURL]
}


struct ImageURL:Decodable{
    var url: String
}
