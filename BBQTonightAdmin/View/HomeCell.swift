//
//  HomeCell.swift
//  BBQTonightAdmin
//
//  Created by Nasim on 4/11/18.
//  Copyright © 2018 Nasim. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {
    var post: Post?{
        didSet{
            self.foodNameLabel.text = post?.foodName
            guard let imageUrl = post?.imageUrl else {
                return
            }
            foodImage.loadImage(urlString: imageUrl)
            
            guard let price = post?.foodPrice else {return}
            foodPriceLabel.text = "\(price)Tk"
            
        }
    }
    
    
    var product: Category? {
        didSet {
            self.foodNameLabel.text = product?.categoryName
            
            guard let categoryImageUrl = product?.imageUrl else {return}
            
            foodImage.loadImage(urlString: categoryImageUrl)
            
            
        }
    }
    
    let backView: UIView = {
        let gv = UIView()
        gv.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        gv.translatesAutoresizingMaskIntoConstraints = false
        return gv
    }()
    
    let foodImage: CustomImageView = {
        let back = CustomImageView()
        back.image = #imageLiteral(resourceName: "menu")
        back.translatesAutoresizingMaskIntoConstraints = false
        back.contentMode = .scaleToFill
        return back
    }()
    
    let foodNameLabel: UILabel = {
        let det = UILabel()
        det.text = "French fries"
        det.translatesAutoresizingMaskIntoConstraints = false
        det.font = UIFont(name: "Times New Roman", size: 18)
        det.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        return det
    }()
    
    
    let foodPriceLabel: UILabel = {
        let num = UILabel()
        num.translatesAutoresizingMaskIntoConstraints = false
        num.font = UIFont(name: "Times New Roman", size: 18)
        num.textColor = #colorLiteral(red: 0.450840652, green: 0.7194982171, blue: 0.2839505076, alpha: 1)
        return num
    }()
    
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(backView)
        backView.addSubview(foodImage)
        backView.addSubview(foodNameLabel)
        backView.addSubview(foodPriceLabel)
        
        backView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 10, paddingRight: 10, paddingBottom: 5, width: 0, height: 0)
        
        foodImage.anchor(top: backView.topAnchor, left: backView.leftAnchor, bottom:  backView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 120, height: 120)
        
        foodNameLabel.anchor(top:  backView.topAnchor, left: foodImage.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 20, paddingRight: 10, paddingBottom: 0, width: 0, height: 60)
        
        foodPriceLabel.anchor(top: foodNameLabel.bottomAnchor, left: foodNameLabel.leftAnchor, bottom:  backView.bottomAnchor, right:  backView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
//    func setOrderCellWith(order: Order) {
//        
//        DispatchQueue.main.async {
//            self.foodNameLabel.text = order.name
//            self.foodPriceLabel.text = order.price
//            guard let imageUrl = order.image else {return}
//            self.foodImage.loadImage(urlString: imageUrl)
//            
//        }
//    }
    
    
}
