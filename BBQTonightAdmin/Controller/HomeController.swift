//
//  HomeController.swift
//  BBQTonightAdmin
//
//  Created by Nasim on 4/10/18.
//  Copyright © 2018 Nasim. All rights reserved.
//

import UIKit
import Firebase

class HomeController: UITableViewController, CDRTranslucentSideBarDelegate{
    
    private let cellId = "cellId"

    var leftSideBar: CDRTranslucentSideBar?
    
    var foodsArray = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Home"
        
        
        tableView.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.9333333333, blue: 0.9529411765, alpha: 1)
        tableView.separatorStyle = .none
        

        // Do any additional setup after loading the view.
        
        tableView.register(HomeCell.self, forCellReuseIdentifier: cellId)
        
        setUpNavigationButton()
        
        setupLeftSideBar()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchAllPosts()
    }
    
    func setUpNavigationButton(){
        let menu = #imageLiteral(resourceName: "menu-1").withRenderingMode(.alwaysOriginal)
        
        let leftBarBut = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.done, target: self, action: #selector(showLeftBar))
        leftBarBut.image = menu
        leftBarBut.tintColor = .white
        self.navigationItem.leftBarButtonItem = leftBarBut
    }
    
    
    func setupLeftSideBar() {
        leftSideBar = CDRTranslucentSideBar()
        leftSideBar?.delegate = self
        leftSideBar?.tag = 0
        leftSideBar?.sideBarWidth = view.frame.width * 0.6
        leftSideBar?.translucentAlpha = 0.75
        leftSideBar?.animationDuration = 0.5
        leftSideBar?.translucentTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        
        let sidebar = SidebarMenu()
        
        self.addChildViewController(sidebar)
        sidebar.view.frame = CGRect(x: 0, y: 100, width: view.frame.width, height: view.frame.height)
        leftSideBar?.setContentViewIn(sidebar.view)
        sidebar.didMove(toParentViewController: self)
        
    }
    
    @objc func showLeftBar() {
        leftSideBar?.show()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! HomeCell
        
        cell.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.9333333333, blue: 0.9529411765, alpha: 1)
        
        let item = foodsArray[indexPath.row]
        
        cell.post = item
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func fetchAllPosts(){
        let ref = Database.database().reference().child("Posts")
        
        ref.observe(.value) { (snapshot) in
            self.foodsArray.removeAll()
            
            let postArray = snapshot.children.allObjects as! [DataSnapshot]
            postArray.forEach({ (snap) in
                let catArray = snap.children.allObjects as! [DataSnapshot]
                catArray.forEach({ (child) in
                    let postId = child.key
                    guard let dictionary = child.value as? [String: Any] else {return}
                    let post = Post(postId: postId, dictionary: dictionary)
                    self.foodsArray.append(post)
                })
            })
            
            self.tableView.reloadData()
            
            
        }
    }
    
    
}
