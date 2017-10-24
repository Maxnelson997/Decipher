//
//  LoginController.swift
//  Decipher
//
//  Created by Max Nelson on 10/20/17.
//  Copyright © 2017 cplusplus. All rights reserved.
//

import UIKit
import Firebase
import CoreData


class LoginController:DecipherController, UITextFieldDelegate {
    
    var headerHeight:CGFloat = 0
    let model = Model.instance
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var current:UITextField = UITextField()
    var context:NSManagedObjectContext!
    
    func uistate(active:Bool) {
        usernameBox.isUserInteractionEnabled = active
        passwordBox.isUserInteractionEnabled = active
        skipButton.isUserInteractionEnabled = active
        loginButton.isUserInteractionEnabled = active
        forgotButton.isUserInteractionEnabled = active
        signupButton.isUserInteractionEnabled = active
    }

    
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
    
    let logo: PLabel = {
//        let img = UIImageView(image: #imageLiteral(resourceName: "textlogo"))
//        img.translatesAutoresizingMaskIntoConstraints = false
//        return img
        let l = PLabel(text: "Decipher", withSize: 70, alignment: .center)
        var txt:NSMutableAttributedString = NSMutableAttributedString(string: "Decipher")
        txt.setAttributes([NSAttributedStringKey.font:UIFont.init(customFont: .ProximaNovaSemibold, withSize: 70)!,NSAttributedStringKey.foregroundColor:UIColor.red], range: NSRange(location:2, length:6))
        l.attributedText =  txt
        return l
    }()
    

    

    fileprivate let usernameBox = PTextFieldWithHeader(customFont: .ProximaNovaSemibold, textSize: 20, headerSize: 15, placeholder: "username")
    fileprivate let passwordBox:PTextFieldWithHeader = {
        
        let n = PTextFieldWithHeader(customFont: .ProximaNovaSemibold, textSize: 20, headerSize: 15, placeholder: "password")
        
        return n
    }()
    
    
    let loginButton:DButton = {
        let b = DButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("login", for: .normal)
        b.setTitleColor(UIColor.MNBlue, for: .normal)
        b.titleLabel?.textAlignment = .right
        b.titleLabel?.font = UIFont.init(customFont: .ProximaNovaSemibold, withSize: 20)
        return b
    }()
    
    let skipButton:DButton = {
        let b = DButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("skip", for: .normal)
        b.titleLabel?.textAlignment = .left
        b.setTitleColor(UIColor.MNBlue, for: .normal)
        b.titleLabel?.font = UIFont.init(customFont: .ProximaNovaSemibold, withSize: 20)
        return b
    }()
    
    
  
    let forgotButton:DButton = {
        let b = DButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("forgot?", for: .normal)
        b.setTitleColor(UIColor.MNTextGrayNew, for: .normal)
        b.titleLabel?.font = UIFont.init(customFont: .ProximaNovaSemibold, withSize: 20)
        return b
    }()
    
    let signupButton:DButton = {
        let b = DButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("sign up", for: .normal)
        b.setTitleColor(UIColor.MNTextGrayNew, for: .normal)
        b.titleLabel?.font = UIFont.init(customFont: .ProximaNovaSemibold, withSize: 20)
        return b
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        usernameBox.delegate = self
        passwordBox.delegate = self
        passwordBox.isSecure = true
        usernameBox.headerColor = .clear
        passwordBox.headerColor = .clear
//        usernameBox.text = "maxnelson997@gmail.com"
//        passwordBox.text = "superdopepassword"
//
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
        
        credentialsContainer.addSubview(loginButton)
        credentialsContainer.addSubview(skipButton)
        
        let logoc = UIStackView()
        logoc.translatesAutoresizingMaskIntoConstraints = false
        logoc.axis = .horizontal

        logoc.addArrangedSubview(forgotButton)
        logoc.addArrangedSubview(signupButton)
        
        
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
            
            
            viewStack.leftAnchor.constraint(greaterThanOrEqualTo: view.rightAnchor ,constant: 5),
            viewStack.rightAnchor.constraint(lessThanOrEqualTo: view.leftAnchor,constant: -5),
            
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
            passwordBox.widthAnchor.constraint(equalTo: credentialsContainer.widthAnchor, constant: -50),
            usernameBox.widthAnchor.constraint(equalTo: credentialsContainer.widthAnchor, constant: -50),
            
            
            boxs.heightAnchor.constraint(equalToConstant: 140 + boxDistance),
            credentialsContainerContainer.heightAnchor.constraint(equalToConstant: 140 + boxDistance + 100),
            credentialsContainer.heightAnchor.constraint(equalToConstant: 140 + boxDistance + 100),
            boxs.centerXAnchor.constraint(equalTo: credentialsContainer.centerXAnchor),
            boxs.centerYAnchor.constraint(equalTo: credentialsContainer.centerYAnchor, constant: -20),
            logoc.heightAnchor.constraint(equalToConstant: 50),
            signupButton.widthAnchor.constraint(equalTo: logoc.widthAnchor, multiplier: 0.5),
            forgotButton.widthAnchor.constraint(equalTo: logoc.widthAnchor, multiplier: 0.5),
            
            
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.widthAnchor.constraint(equalTo: credentialsContainer.widthAnchor, multiplier: 0.5),

            skipButton.widthAnchor.constraint(equalTo: credentialsContainer.widthAnchor, multiplier: 0.5),
            skipButton.rightAnchor.constraint(equalTo: loginButton.leftAnchor),
            skipButton.leftAnchor.constraint(equalTo: credentialsContainer.leftAnchor),
            skipButton.bottomAnchor.constraint(equalTo: credentialsContainer.bottomAnchor),
            skipButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.leftAnchor.constraint(equalTo: skipButton.rightAnchor),
            loginButton.rightAnchor.constraint(equalTo: credentialsContainer.rightAnchor),
            loginButton.bottomAnchor.constraint(equalTo: credentialsContainer.bottomAnchor),
          
            
          

            
            credentialsContainer.topAnchor.constraint(equalTo: credentialsContainerContainer.topAnchor),
            credentialsContainer.bottomAnchor.constraint(equalTo: credentialsContainerContainer.bottomAnchor),
            credentialsContainer.widthAnchor.constraint(equalTo: credentialsContainerContainer.widthAnchor, multiplier: 0.75),
            credentialsContainer.centerYAnchor.constraint(equalTo: credentialsContainerContainer.centerYAnchor),
            credentialsContainer.centerXAnchor.constraint(equalTo: credentialsContainerContainer.centerXAnchor),
            
            ])
        
        var constantForWidth:CGFloat = 500
        if UIDevice.current.model == "iPhone" {
            constantForWidth = view.frame.width
        }
        let topspace = UIView()
        topspace.translatesAutoresizingMaskIntoConstraints = false
        topspace.widthAnchor.constraint(equalToConstant: constantForWidth).isActive = true
        topspace.heightAnchor.constraint(equalToConstant: 0).isActive = true
        viewStack.addArrangedSubview(topspace)
        viewStack.addArrangedSubview(logo)
        viewStack.addArrangedSubview(credentialsContainerContainer)
        viewStack.addArrangedSubview(logoc)
        
        usernameBox.becomeFirstResponder()
        
        //        self.logo.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.loginButton.addTarget(self, action: #selector(self.login), for: .touchUpInside)
        forgotButton.addTarget(self, action: #selector(self.forgot), for: .touchUpInside)
        signupButton.addTarget(self, action: #selector(self.signup), for: .touchUpInside)
        skipButton.addTarget(self, action: #selector(self.skip), for: .touchUpInside)
        

        retrieveCredentialsFromCoreData()
    }
    
    @objc func login() {
        let email = usernameBox.text
        let password = passwordBox.text
        if isSignupEnabled {

            //sign up user for decipher in firebase console

            appDelegate.createUser(email:email,password:password)
    
        } else {
            
            appDelegate.Login(email:email,password:password)
        }
  
    }
    var isSignupEnabled:Bool = false
    @objc func signup() {
        usernameBox.headerText = "EMAIL"
        loginButton.text = "sign up"
        skipButton.text = "cancel"
        signupButton.alpha = 0
        forgotButton.alpha = 0
        isSignupEnabled = true
//        usernameBox.text = ""
//        passwordBox.text = ""
//        usernameBox.becomeFirstResponder()
    }
    
    @objc func forgot() {
        if isSignupEnabled {
            //
        } else {
            //send email for reset
            //forgot
            var description:String = ""
            var title:String = ""
            Auth.auth().sendPasswordReset(withEmail: usernameBox.text) { error in
                if let error = error
                {
                    title = "Error"
                    if error.localizedDescription == "There is no user record corresponding to this identifier. The user may have been deleted." {
                        description = "There is no user associated with this email address, check the email above."
                    } else {
                        description = "There was an error resetting your password, try again or come back later."
                    }
                    print(error.localizedDescription)
                    // Error - Unidentified Email
                }
                else
                {
                    title = "Success"
                    description = "We've sent a link to reset your password to the email above."

                    // Success - Sent recovery email
                }
                let alertController = UIAlertController(title: title, message: description, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    @objc func skip() {
        if isSignupEnabled {
            //cancel
            //go back to sign in
            signupButton.alpha = 1
            forgotButton.alpha = 1
            usernameBox.headerText = "USERNAME"
            loginButton.text = "login"
            skipButton.text = "skip"
            isSignupEnabled = false
            if usernameBox.isFocused {
                usernameBox.resignFirstResponder()
            }
            else if passwordBox.isFocused {
                passwordBox.resignFirstResponder()
            }
        } else {
//           appDelegate.Login(email:"guest@guest.com",password:"guestacct")
            //skip
            appDelegate.Login(withoutCredentials: true)
        }
    }

    
    //core data
    func saveCredentialsInCoreData() {
        var coreDataUser:NSManagedObject!
        
        //then save the new one. removing the previous one each time prevents the model from storing the user multiple times. this is if we are deleting the core data objects. rn ignore this comment
        
        //check if user exists
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Login")
        
        request.returnsObjectsAsFaults = false
        if let results = try? context.fetch(request) {
            if results.count != 0 {
                //a user exists
                coreDataUser = results.first as! NSManagedObject
            } else {
                //create a user
                coreDataUser = NSEntityDescription.insertNewObject(forEntityName: "Login", into: context)
            }
        } else {
            //failed
            print("hmm failed?")
        }
        //save new user
        
        coreDataUser.setValue(usernameBox.text, forKey: "username")
        coreDataUser.setValue(passwordBox.text, forKey: "password")
        coreDataUser.setValue(Model.instance.isloggedin, forKey: "isloggedin")
    
        
        //store new user
        if usernameBox.text != "" && passwordBox.text != "" {
            do
            {
                try context.save()
                print("username saved in Core Data model: \(String(describing: coreDataUser.value(forKey: "username")!))")
                print("password saved in Core Data model: \(String(describing: coreDataUser.value(forKey: "password")!))")
                print("isloggedin saved in Core Data model: \(String(describing: coreDataUser.value(forKey: "isloggedin")!))")
            }
            catch
            {
                print("hmm error saving credentials")
            }
        } else {
            //empty
        }
        
    }
    
    func retrieveCredentialsFromCoreData() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Login")
        
        request.returnsObjectsAsFaults = false
        
        do
        {
            let results = try context.fetch(request)
            
            if results.count != 0 {
                //username and password are indeed in there. for loop even tho there will always only be 1 value
                for result in results as! [NSManagedObject]{
               
                    if let username = result.value(forKey: "username") as? String {
                        usernameBox.text = username
                        print("username retrieved: \(username)")
                    }
                    if let password = result.value(forKey: "password") as? String {
                        passwordBox.text = password
                        print("password retrieved: \(password)")
                    }
                    if let isloggedin = result.value(forKey: "isloggedin") as? Bool {
                        print("isloggedin retrieved: \(isloggedin)")
                        
                        if isloggedin && !usernameBox.text.isEmpty && !passwordBox.text.isEmpty {
                            print("logging in with credentials from core data")
                            (UIApplication.shared.delegate as! AppDelegate).Login(email: usernameBox.text, password: passwordBox.text)
                        }
                    }
   
                    
                }
                    
            } else {
            print("username password not saved in Core Data")
            }
        }
        catch
        {
            print("hmm error retreiving credentials")
        }
    }
    
}
