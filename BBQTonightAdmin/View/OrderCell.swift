//
//  OrderCell.swift
//  BBQTonightAdmin
//
//  Created by Nasim on 4/14/18.
//  Copyright © 2018 Nasim. All rights reserved.
//

import UIKit

class OrderCell: UICollectionViewCell {
    
    var order: Order?{
        didSet{
            guard let url = order?.imageUrl else {return}
            self.imageView.loadImage(urlString: url)
            
            self.nameLabel.text = order?.name
            
            guard let quantity = order?.quantity else {return}
            self.quantityLabel.text = "Quantity: \(quantity)"
        }
    }
    
    
    let imageView: CustomImageView = {
        let iv = CustomImageView()
        iv.image = #imageLiteral(resourceName: "burgur101").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .redraw
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let topBlackView: UIView = {
        let tb = UIView()
        tb.backgroundColor = .black
        tb.alpha = 0.6
        tb.translatesAutoresizingMaskIntoConstraints = false
        return tb
    }()
    
    let bottomBlackView: UIView = {
        let tb = UIView()
        tb.backgroundColor = .black
        tb.alpha = 0.6
        tb.translatesAutoresizingMaskIntoConstraints = false
        return tb
    }()
    
    let nameLabel: UILabel = {
        let ql = UILabel()
        ql.translatesAutoresizingMaskIntoConstraints = false
        ql.text = "Gourmet Steak"
        ql.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return ql
    }()
    
    let quantityLabel: UILabel = {
       let ql = UILabel()
       ql.translatesAutoresizingMaskIntoConstraints = false
       ql.text = "Quntity: 0"
       ql.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
       return ql
    }()
    
    
    let deliverButton: UIButton = {
        let db = UIButton()
        db.translatesAutoresizingMaskIntoConstraints = false
        db.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        db.layer.cornerRadius = 15
        db.layer.masksToBounds = true
        db.setTitle("Delivered", for: .normal)
        return db
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .blue
        
        setUpViews()
    }
    
    func setUpViews(){
        addSubview(imageView)
        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
//        imageView.addSubview(topBlackView)
//        topBlackView.anchor(top: imageView.topAnchor, left: imageView.leftAnchor, bottom: nil, right: imageView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 40)
        
        imageView.addSubview(bottomBlackView)
        bottomBlackView.anchor(top: imageView.topAnchor, left: imageView.leftAnchor, bottom: imageView.bottomAnchor, right: imageView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
        imageView.addSubview(quantityLabel)
        quantityLabel.anchor(top: nil, left: imageView.leftAnchor, bottom: imageView.bottomAnchor, right: imageView.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingRight: 0, paddingBottom: 10, width: 0, height: 20)
        
        imageView.addSubview(nameLabel)
        nameLabel.anchor(top: nil, left: quantityLabel.leftAnchor, bottom: quantityLabel.topAnchor, right: quantityLabel.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 10, width: 0, height: 20)
        
        imageView.addSubview(deliverButton)
        deliverButton.anchor(top: imageView.topAnchor, left: nil, bottom: nil, right: imageView.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingRight: 10, paddingBottom: 0, width: frame.width / 2, height: 30)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
