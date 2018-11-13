//
//  OrderVC.swift
//  BBQTonightAdmin
//
//  Created by Nasim on 4/14/18.
//  Copyright © 2018 Nasim. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"

class OrderVC: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    var refOrders: DatabaseReference!
    
    var ordersArray = [Order]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        refOrders = Database.database().reference().child("Orders")
        
        setUpNavBar()
        
        collectionView?.backgroundColor = .white


        self.collectionView!.register(OrderCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func setUpNavBar(){
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
        
        navigationItem.title = "All orders"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchPlacedOrders()
    }

   

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return ordersArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! OrderCell
    
        let item = ordersArray[indexPath.item]
        cell.order = item
        
    
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 3) / 2
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
    }
    
    func fetchPlacedOrders(){
        refOrders.observe(.value) { (snapshot) in
            self.ordersArray.removeAll()
            
            let orderArray = snapshot.children.allObjects as! [DataSnapshot]
            orderArray.forEach({ (snap) in
                let catArray = snap.children.allObjects as! [DataSnapshot]
                catArray.forEach({ (child) in
                    let postId = child.key
                    guard let dictionary = child.value as? [String: Any] else {return}
                    let post = Order(dictionary: dictionary)
                    self.ordersArray.append(post)
                })
                
            })
            print(orderArray)
            
            self.collectionView?.reloadData()
            
            
        }
        
        
    }
    

    

}
