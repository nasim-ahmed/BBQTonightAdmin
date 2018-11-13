//
//  LoginVC.swift
//  BBQTonightAdmin
//
//  Created by Nasim on 4/10/18.
//  Copyright © 2018 Nasim. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    
    let signInLabel: UILabel = {
        let signInLabel = UILabel()
        signInLabel.text = "SIGN IN"
        signInLabel.textColor = #colorLiteral(red: 0.3899413943, green: 0.7794983983, blue: 0.1864124238, alpha: 1)
        signInLabel.font = UIFont(name: "Avenir-Light", size: 25)
        signInLabel.textAlignment = .center
        signInLabel.translatesAutoresizingMaskIntoConstraints = false
        return signInLabel
    }()
    
    let emailTextField:UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Email",
                                                               attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        tf.backgroundColor = UIColor(white: 0, alpha:0.03)
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.borderStyle = .bezel
        tf.textColor = .white
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    let passwordTextField:UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Password",
                                                      attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        tf.isSecureTextEntry = true
        tf.backgroundColor = UIColor(white: 0, alpha:0.03)
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.textColor = .white
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        tf.borderStyle = .bezel
        return tf
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.4146783352, green: 0.7874323726, blue: 0.1680292189, alpha: 1)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.isEnabled = false
        return button
    }()
    
    
    let backgroundIV: UIImageView = {
        let background = UIImageView()
        background.image = #imageLiteral(resourceName: "menu")
        background.translatesAutoresizingMaskIntoConstraints = false
        background.contentMode = .center
        return background
    }()
    
    let blackView: UIVisualEffectView = {
        let bv = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        bv.alpha = 0.7
        return bv
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        view.backgroundColor = .white
        
        setUpViews()
        
        view.addSubview(signInLabel)
        signInLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop:60, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 150)
        signInLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        setupInputFields()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleDismiss))
        
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func handleDismiss(){
        view.endEditing(true)
    }
    
    func setUpViews(){
        view.addSubview(backgroundIV)
        backgroundIV.addSubview(blackView)
        
        backgroundIV.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
        blackView.anchor(top: backgroundIV.topAnchor, left: backgroundIV.leftAnchor, bottom: backgroundIV.bottomAnchor, right: backgroundIV.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
    }
    
    fileprivate func setupInputFields(){
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        stackView.anchor(top: signInLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 40, paddingLeft: 40, paddingRight: 40, paddingBottom: 0, width: 0, height: 140)
        
    }
    
    @objc func handleTextInputChange(){
        let isFormValid = emailTextField.text?.characters.count ?? 0 > 0  && passwordTextField.text?.characters.count ?? 0 > 0
        
        if isFormValid{
            loginButton.isEnabled = true
            loginButton.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        } else{
            loginButton.isEnabled = false
            loginButton.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        }
    }
    
    @objc func handleLogin(){
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        
        Auth.auth().signIn(withEmail:  email, password: password) { (user, err) in
            if  let err = err{
                print("Failed to sign in with error:", err)
                return
            }
            print("Successfully logged back in with user:", user?.uid ?? "")
            
            let homeController = UINavigationController(rootViewController: HomeController())
            self.present(homeController, animated: true, completion: nil)
            
//            let homeController = HomeController()
//            self.navigationController?.pushViewController(homeController, animated: true)
        }
        
    }
}
