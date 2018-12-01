//
//  ViewController.swift
//  ChaosComs
//
//  Created by Zubair Amjad on 11/26/18.
//  Copyright © 2018 Zubair Amjad. All rights reserved.
//

import UIKit
import Firebase

class RegistrationViewController: UIViewController {


    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBAction func login_screen_button(_ sender: UIButton) {

        let loginScreen = self.storyboard?.instantiateViewController(withIdentifier: "go_back") as! LoginViewController
        
        self.navigationController?.pushViewController(loginScreen, animated: true)
    }
    
    
    @IBAction func registe_button(_ sender: UIButton) {
        
        guard let emailText = email.text else {
            print("Didn't work")
            return
            
        }
        
        guard let passwordText = password.text else  {
            print("Didn't work")
            return
        }

        registerUser(email: emailText, password: passwordText)
        let messageScreen = self.storyboard?.instantiateViewController(withIdentifier: "message_screen") as! MessageViewController
            
        self.navigationController?.pushViewController(messageScreen, animated: true)
        
        
        let ref: DatabaseReference! = Database.database().reference()
        let currentUser = Auth.auth().currentUser
        
        guard let currentUserID = currentUser?.uid else { return }
        
        let userIDRef = ref.child("users").child(currentUserID)
        let nameRef = userIDRef.child("name")
        let passwordRef = userIDRef.child("password")
        let emailRef = userIDRef.child("email")


        nameRef.setValue(username.text)
        passwordRef.setValue(passwordText)
        emailRef.setValue(emailText)
        
    }
    
    func registerUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            guard let user = authResult?.user else { return }
        }

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}
