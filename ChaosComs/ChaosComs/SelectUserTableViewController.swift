//
//  SelectUserTableViewController.swift
//  ChaosComs
//
//  Created by Zubair Amjad on 12/2/18.
//  Copyright © 2018 Zubair Amjad. All rights reserved.
//

import UIKit
import Firebase

struct User {
    let name: String?
    let uid: String?
}


class SelectUserTableViewController: UITableViewController {
    
    @IBAction func goBackToLogin(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    var users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let uid = Auth.auth().currentUser?.uid
        
        let ref: DatabaseReference! = Database.database().reference()
        
        ref.child("users").queryOrderedByKey().observe(.childAdded) { (snapshot) in
            let name = (snapshot.value as? NSDictionary)?["name"] as? String ?? ""
            
            let uid = (snapshot.value as? NSDictionary)?["uid"] as? String ?? ""
            
            self.users.append(User(name: name, uid: uid))
                
            self.tableView.reloadData()
            
        }
        
        tableView.reloadData()
        
    }
     
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let nameTxtField = cell.viewWithTag(1) as! UILabel
        nameTxtField.text = users[indexPath.row].name
        return cell
    }
}
