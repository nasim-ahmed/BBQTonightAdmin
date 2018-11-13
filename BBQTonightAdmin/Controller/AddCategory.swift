//
//  AddCategory.swift
//  BBQTonightAdmin
//
//  Created by Nasim on 4/11/18.
//  Copyright © 2018 Nasim. All rights reserved.
//

import UIKit
import Firebase

class AddCategory: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var refCategories: DatabaseReference!
    
    var passedCategory: Category?

    
    let addImageButton:UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "SplashImage").withRenderingMode(.alwaysOriginal), for: .normal)
        button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        button.titleLabel?.font =  UIFont(name: "Arial-BoldMT", size: 30)
        button.setTitle("Add Image", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleAddImage), for: .touchUpInside)
        return button
    }()
    
    
    
    @objc func handleAddImage(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage{
            addImageButton.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)

        }else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            addImageButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }

        dismiss(animated: true, completion: nil)
    }
    
    let nameTextField:UITextField = {
        let tf = UITextField()
        tf.placeholder = "Category Name"
        tf.backgroundColor = UIColor(white: 0, alpha:0.03)
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.borderStyle = .roundedRect
        return tf
    }()
   
    
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add Category", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.4111182988, green: 0.7755476236, blue: 0.1703226566, alpha: 1)
        button.addTarget(self, action: #selector(handleAddCategory), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
 

    
    @objc func handleAddCategory(){
        
        guard let categoryName = nameTextField.text else {return}

        
        
        if passedCategory != nil{
            guard let image = self.addImageButton.imageView?.image else { return }
            
            guard let uploadData = UIImageJPEGRepresentation(image, 0.3) else {return}
            
            let fileName = NSUUID().uuidString
            
            Storage.storage().reference().child("categories").child(fileName).putData(uploadData, metadata: nil) { (metadata, err) in
                if let err = err{
                    print("Failed to upload profile image:", err)
                }
                guard let categoryImageUrl = metadata?.downloadURL()?.absoluteString else {return}
                
                
                guard let id = self.passedCategory?.catId else {return}
                
                self.updateCategory(id: id, name: categoryName, image: categoryImageUrl)
         
                
                self.navigationController?.popViewController(animated: true)
            }
        }else{
            guard let image = self.addImageButton.imageView?.image else { return }
            
            guard let uploadData = UIImageJPEGRepresentation(image, 0.3) else {return}
            
            let fileName = NSUUID().uuidString
            
            Storage.storage().reference().child("categories").child(fileName).putData(uploadData, metadata: nil) { (metadata, err) in
                if let err = err{
                    print("Failed to upload profile image:", err)
                }
                guard let categoryImageUrl = metadata?.downloadURL()?.absoluteString else {return}
                
                
                let dictionaryValue = ["name" : categoryName, "image" : categoryImageUrl]
                
                let key = self.refCategories.childByAutoId().key
                
                self.refCategories.child(key).setValue(dictionaryValue)
                
                self.navigationController?.popViewController(animated: true)
            }
        }
        
       
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL) {
        print("Download Started")
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                guard let im = UIImage(data: data) else {return}
                self.addImageButton.setImage(im.withRenderingMode(.alwaysOriginal), for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if passedCategory != nil{
            guard let url = passedCategory?.imageUrl else {return}
            if let url = URL(string: url){
                downloadImage(url: url)
            }
            
            nameTextField.text = passedCategory?.categoryName
            
            signUpButton.setTitle("Update", for: .normal)
        }
        
        
        view.backgroundColor = .white
        
    
        view.addSubview(addImageButton)
       
        
        let height:CGFloat = 250
        
        addImageButton.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: height)
        
        //getting a reference to the node artists
        refCategories = Database.database().reference().child("Categories")
        
        
        setUpInputFields()
        
        let tap = UITapGestureRecognizer(target: self, action:#selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    fileprivate func setUpInputFields(){
        
        view.addSubview(nameTextField)
        nameTextField.anchor(top: addImageButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 35, paddingLeft: 10, paddingRight: 10, paddingBottom: 0, width: 0, height: 40)
        
        view.addSubview(signUpButton)
        signUpButton.anchor(top: nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 60)
        
    }
    
    func updateCategory(id:String, name:String, image: String){
        //creating artist with the new given values
        let category = [
            "name": name,
            "image": image
        ]
        
        //updating the artist using the key of the artist
        refCategories.child(id).setValue(category)
        
    }
  

}
