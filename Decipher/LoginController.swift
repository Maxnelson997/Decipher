//
//  LoginController.swift
//  Decipher
//
//  Created by Max Nelson on 10/20/17.
//  Copyright © 2017 cplusplus. All rights reserved.
//

import UIKit


class LoginController:DecipherController, UITextFieldDelegate {
    
    var headerHeight:CGFloat = 0
    let model = Model.instance
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var current:UITextField = UITextField()
    
   
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.3, animations: {
            self.navigationController?.navigationBar.transform = CGAffineTransform(translationX: 0, y: -200)
        }) { (false) in }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.model == "iPhone" {
            if UIDevice.current.orientation.isLandscape {
                UIView.animate(withDuration: 0.3, animations: {
                    self.logo.alpha = 0
                })
                
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.logo.alpha = 1
                })
            }
            
        }
        
    }
    
    
    
    

    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        current = textField
        //        self.view.animateView(direction: .up, distance: 100)
        
        UIView.animate(withDuration: 0.3) {
            self.view.transform = CGAffineTransform(translationX: 0, y: -100)
            self.logo.alpha = 0.5
            var transform = CGAffineTransform.identity
            transform = transform.translatedBy(x: 0, y: 100)
            //            transform = transform.scaledBy(x: 1.3, y: 1.3)
            //            self.logo.transform = transform
            self.current.transform = CGAffineTransform(scaleX: 1.05, y: 1.1)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.view.animateView(direction: .back, distance: 0)
        UIView.animate(withDuration: 0.3) {
            self.current.transform = CGAffineTransform(scaleX: 1, y: 1)
            
        }
    }
    
    
    @objc func dismissText() {
        current.resignFirstResponder()
        UIView.animate(withDuration: 0.3) {
            var transform = CGAffineTransform.identity
            transform = transform.translatedBy(x: 0, y: 0)
            transform = transform.scaledBy(x: 1.3, y: 1.3)
            //            self.logo.transform = transform
            self.logo.alpha = 1
        }
    }
    
    
    
    var viewStack:UIStackView = { 
        let s = UIStackView()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.axis = .vertical
        s.backgroundColor = UIColor.clear
        s.distribution = UIStackViewDistribution.equalSpacing
        return s
    }()
    
    let logo: UIImageView = {
        let img = UIImageView(image: #imageLiteral(resourceName: "textlogo"))
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    

    fileprivate let usernameBox = PTextFieldWithHeader(customFont: .ProximaNovaLight, textSize: 20, headerSize: 15, placeholder: "username")
    fileprivate let passwordBox = PTextFieldWithHeader(customFont: .ProximaNovaLight, textSize: 20, headerSize: 15, placeholder: "password")
  
    let forgotButton:UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("forgot?", for: .normal)
        b.setTitleColor(UIColor.MNBlue, for: .normal)
        b.titleLabel?.font = UIFont.init(customFont: .ProximaNovaSemibold, withSize: 20)
        return b
    }()
    
    let loginButton:UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("login", for: .normal)
        b.setTitleColor(UIColor.MNBlue, for: .normal)
        b.titleLabel?.font = UIFont.init(customFont: .ProximaNovaSemibold, withSize: 20)
        return b
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        usernameBox.delegate = self
        passwordBox.delegate = self
        usernameBox.headerColor = .clear
        passwordBox.headerColor = .clear
        usernameBox.text = "maxnelson997@gmail.com"
        passwordBox.text = "superdopepassword"
       
        viewStack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissText)))
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissText)))
        view.addSubview(viewStack)
        
        let boxs = UIView()
        boxs.translatesAutoresizingMaskIntoConstraints = false
        
        boxs.addSubview(usernameBox)
        boxs.addSubview(passwordBox)
        
        let credentialsContainer = UIView()
        credentialsContainer.translatesAutoresizingMaskIntoConstraints = false
        credentialsContainer.addSubview(boxs)

        
        let credentialsContainerContainer = UIView()
        credentialsContainerContainer.translatesAutoresizingMaskIntoConstraints = false
        credentialsContainerContainer.addSubview(credentialsContainer)
        credentialsContainer.backgroundColor = UIColor.MNGray.withAlphaComponent(0.8)
        credentialsContainer.layer.cornerRadius = 8
        
        let logoc = UIStackView()
        logoc.translatesAutoresizingMaskIntoConstraints = false
        logoc.axis = .horizontal

        logoc.addArrangedSubview(forgotButton)
        logoc.addArrangedSubview(loginButton)
        
        
        var distance:CGFloat = 0
        var boxDistance:CGFloat = 0
        if UIDevice.current.model == "iPhone" {
            distance = 5
            boxDistance = 50
        } else {
            distance = 50
            boxDistance = 50
        }
        
        NSLayoutConstraint.activate([
            
            viewStack.leftAnchor.constraint(greaterThanOrEqualTo: view.leftAnchor, constant: 5),
            viewStack.rightAnchor.constraint(lessThanOrEqualTo: view.rightAnchor, constant: -5),
            viewStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            viewStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            viewStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //            viewStack.centerYAnchor.co
            
            usernameBox.topAnchor.constraint(equalTo: boxs.topAnchor),
            usernameBox.leftAnchor.constraint(equalTo: boxs.leftAnchor, constant: distance),
            usernameBox.rightAnchor.constraint(equalTo: boxs.rightAnchor, constant: -1 * distance),
            passwordBox.bottomAnchor.constraint(equalTo: boxs.bottomAnchor),
            passwordBox.leftAnchor.constraint(equalTo: boxs.leftAnchor, constant: distance),
            passwordBox.rightAnchor.constraint(equalTo: boxs.rightAnchor, constant: -1 * distance),
            

            boxs.heightAnchor.constraint(equalToConstant: 140 + boxDistance),
            credentialsContainerContainer.heightAnchor.constraint(equalToConstant: 140 + boxDistance + 100),
            credentialsContainer.heightAnchor.constraint(equalToConstant: 140 + boxDistance + 100),
            boxs.centerXAnchor.constraint(equalTo: credentialsContainer.centerXAnchor),
            boxs.centerYAnchor.constraint(equalTo: credentialsContainer.centerYAnchor),
            logoc.heightAnchor.constraint(equalToConstant: 50),
            loginButton.widthAnchor.constraint(equalTo: logoc.widthAnchor, multiplier: 0.5),
            forgotButton.widthAnchor.constraint(equalTo: logoc.widthAnchor, multiplier: 0.5),
            
            credentialsContainer.topAnchor.constraint(equalTo: credentialsContainerContainer.topAnchor),
            credentialsContainer.bottomAnchor.constraint(equalTo: credentialsContainerContainer.bottomAnchor),
            credentialsContainer.widthAnchor.constraint(equalTo: credentialsContainerContainer.widthAnchor, multiplier: 0.75),
            credentialsContainer.centerYAnchor.constraint(equalTo: credentialsContainerContainer.centerYAnchor),
            credentialsContainer.centerXAnchor.constraint(equalTo: credentialsContainerContainer.centerXAnchor),
            
            ])
        
        viewStack.addArrangedSubview(logo)
        viewStack.addArrangedSubview(credentialsContainerContainer)
        viewStack.addArrangedSubview(logoc)
        
        
        //        self.logo.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.loginButton.addTarget(self, action: #selector(self.login), for: .touchUpInside)

    }
    
    @objc func login() {
        appDelegate.Login()
    }

    
}
