//
//  SettingsViewController.swift
//  FirstProject
//
//  Created by Софья Куликова on 03.10.2023.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        tableView.backgroundColor = .clear
        
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        tableView.register(SettingsTableViewCell.nib(), forCellReuseIdentifier: SettingsTableViewCell.identifire)
        
      
    }
    

  

}


extension SettingsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  Settings.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell  {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifire, for: indexPath) as! SettingsTableViewCell
        
        
        let setting = Settings.allCases[indexPath.row]
        

        cell.configure(texts:  setting.title, image: setting.icon)
        
        cell.selectionStyle = .none
        
           cell.settingsView.layer.cornerRadius = 10
        
        
        
              return cell
    }

    
    
}
