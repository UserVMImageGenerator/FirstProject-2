//
//  StructSettings.swift
//  FirstProject
//
//  Created by Софья Куликова on 03.10.2023.
//



import Foundation
import UIKit

enum Settings: String, CaseIterable {
    case support
    case shareApp
    case provicyPolicy
    case termsOfUse


    var title: String {
        switch self {

        case .support:
            return "Support"
        case .shareApp:
            return "Share app"
        case .provicyPolicy:
            return "Provicy Policy"
        case .termsOfUse:
            return "Terms Of Use"
        }
    }

    var icon: UIImage {
        return UIImage(named: self.rawValue)!
    }
}
