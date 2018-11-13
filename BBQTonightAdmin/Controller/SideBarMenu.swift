//
//  SideBarMenu.swift
//  BBQTonightAdmin
//
//  Created by Nasim on 4/11/18.
//  Copyright © 2018 Nasim. All rights reserved.
//

import UIKit

import UIKit

class SidebarMenu: UITableViewController {
    
    private let cellId = "cellId"
    
    var menus = [Sidebar]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpMenus()
        
        tableView.backgroundColor = .clear
        self.tableView.separatorStyle = .none
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menus.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 130
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cell.backgroundColor = .clear
  
        cell.textLabel?.text = menus[indexPath.row].name
        
        return cell
    }
    
    func setUpMenus(){
        let menu1 = Sidebar(name: "All categories")
        let menu2 = Sidebar(name: "All food")
        let menu3 = Sidebar(name: "Orders")

        menus = [menu1, menu2, menu3]
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let categoryVC = CategoryVC()
            navigationController?.pushViewController(categoryVC, animated: true)
        }else if indexPath.row == 1{
            let homeController = HomeController()
            navigationController?.pushViewController(homeController, animated: true)
        }else if indexPath.row == 2{
            let layout = UICollectionViewFlowLayout()
            let orderVC = OrderVC(collectionViewLayout: layout)
            
            navigationController?.pushViewController(orderVC, animated: true)
        }
    }
    
    
    
    
}
