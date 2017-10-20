//
//  LoginController.swift
//  Decipher
//
//  Created by Max Nelson on 10/20/17.
//  Copyright © 2017 cplusplus. All rights reserved.
//

import UIKit


class LoginController:DecipherController {
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.3, animations: {
            self.navigationController?.navigationBar.transform = CGAffineTransform(translationX: 0, y: -200)
        }) { (false) in }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        deli.showBar()
    }
    
    let deli = UIApplication.shared.delegate as! AppDelegate

    override func start() {
        let login = UIButton()
        login.translatesAutoresizingMaskIntoConstraints = false
        login.layer.masksToBounds = true
        login.layer.cornerRadius = 8
        login.backgroundColor = login.titleLabel?.textColor.withAlphaComponent(0.8)
        login.setTitle("LOGIN BOI", for: .normal)
//        login.setTitleColor(UIColor.black, for: .normal)
        login.addTarget(deli, action: #selector(deli.Login), for: .touchUpInside)
        view.addSubview(login)
        NSLayoutConstraint.activate([
            login.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            login.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            login.heightAnchor.constraint(equalToConstant: 50),
            login.widthAnchor.constraint(equalToConstant: 200),
            ])
    }
    
 

    
}
