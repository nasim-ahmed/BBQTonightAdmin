//
//  CategoryVC.swift
//  BBQTonightAdmin
//
//  Created by Nasim on 4/11/18.
//  Copyright © 2018 Nasim. All rights reserved.
//

import UIKit
import Firebase

class CategoryVC: UITableViewController {
    
    let blurredView: UIVisualEffectView = {
        let bv = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        bv.alpha = 0.7
        bv.translatesAutoresizingMaskIntoConstraints = false
        return bv
    }()
    
    
    private let cellId = "cellId"
    
    var refCategories: DatabaseReference!
    
    var fetchedCategories = [Category]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        tableView.separatorStyle = .none
        
        let navBar = self.navigationController?.navigationBar
        
        // change the bar tint color to change what the color of the bar itself looks like
        navBar?.barTintColor = UIColor.white
        
        // tint color changes the color of the nav item colors eg. the back button
        navBar?.tintColor = UIColor.black
        
        // if you notice that your nav bar color is off by a bit, sometimes you will have to
        // change it to not translucent to get correct color
        navBar?.isTranslucent = false
        
        // the following attribute changes the title color
        navBar?.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
        
        navigationItem.title = "Categories"
        
        tableView.backgroundColor = .white
        
        tableView.register(HomeCell.self, forCellReuseIdentifier: cellId)

        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddCategory))
        navigationItem.rightBarButtonItem = rightBarButton
        
         setUpViews()
        
    }
    
    func setUpViews(){
        view.addSubview(blurredView)
        
        blurredView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
    
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       fetchAllCategories()
 
    }
    
    
    @objc func handleAddCategory(){
//        let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.alert)
//        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
//        self.present(alert, animated: true, completion: nil)
        let addCategory = AddCategory()
        navigationController?.pushViewController(addCategory, animated: true)
    
    }

    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedCategories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! HomeCell
        
        
        cell.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.9333333333, blue: 0.9529411765, alpha: 1)
        
        let item = fetchedCategories[indexPath.row]
        cell.product = item
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
 

    
    func fetchAllCategories(){
        refCategories = Database.database().reference().child("Categories")
        
        refCategories.observeSingleEvent(of: .value) { (snapshot) in
            self.fetchedCategories.removeAll()
            
            guard let dictionaries = snapshot.value as? [String: Any] else {return}

            dictionaries.forEach({ (key, value) in

                guard let categoryDictionary = value as? [String: Any] else {return}

                let category = Category(catId: key, dictionary: categoryDictionary)
                self.fetchedCategories.append(category)
            })

            self.tableView?.reloadData()

        }
       
    }
  
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//       let item = fetchedCategories[indexPath.row]
        
//        let category  = fetchedCategories[indexPath.row]
//
//        //building an alert
//        let alertController = UIAlertController(title: category.categoryName, message: "Give new values to update ", preferredStyle: .alert)
//
//        //the confirm action taking the inputs
//        let confirmAction = UIAlertAction(title: "Enter", style: .default) { (_) in
//
//            //getting artist id
//            let id = category.catId
//
//            //getting new values
//            guard let name = alertController.textFields?[0].text else {return}
//
//            //calling the update method to update artist
//            self.updateCategory(id: id, name: name)
//
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//
//        }
//
//        //the cancel action doing nothing
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
//
//
//
//        //adding two textfields to alert
//        alertController.addTextField { (textField) in
//            textField.text = category.categoryName
//        }
//
//
//        //adding action
//        alertController.addAction(confirmAction)
//        alertController.addAction(cancelAction)
//
//        //presenting dialog
//        present(alertController, animated: true, completion: nil)
        
        let category = fetchedCategories[indexPath.row]
        
        let addCat = AddCategory()
        addCat.passedCategory = category
        navigationController?.pushViewController(addCat, animated: true)
        

    }
    
    
    func updateCategory(id:String, name:String){
        //creating artist with the new given values
        let category = [
                      "name": name
        ]
        
        //updating the artist using the key of the artist
        refCategories.child(id).setValue(category)
    
    }

    

}
