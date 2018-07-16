//
//  FirstViewController.swift
//  Firebase(exam)
//
//  Created by Yusuf DEMİRKOPARAN on 4.07.2018.
//  Copyright © 2018 Yusuf DEMİRKOPARAN. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SDWebImage
class feedVC: UIViewController,UITableViewDelegate, UITableViewDataSource {

    var userNameArray = [String]()
    var userCommentArray = [String]()
    var userImageArray = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.delegate = self
        tableView.dataSource = self
         getDataFromServer()
    }
    
    func getDataFromServer() {
        
        Database.database().reference().child("user").observe(DataEventType.childAdded) { (snapshot) in
            
            let values = snapshot.value! as! NSDictionary
            let post = values["post"] as! NSDictionary
            let postIDs = post.allKeys
            
            for id in postIDs {
                
                let singlePost = post[id] as! NSDictionary
                self.userNameArray.append(singlePost["postedby"] as! String )
                self.userCommentArray.append(singlePost["posttex"] as! String )
                self.userImageArray.append(singlePost["image"] as! String)
                
            }
            self.tableView.reloadData()
            
            
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell") as! tableCells
         cell.homeComment.text = userCommentArray[indexPath.row]
         cell.homeuserName.text = userNameArray[indexPath.row]
         cell.homaImage.sd_setImage(with: URL(string: self.userImageArray[indexPath.row]))
         return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userNameArray.count
    }
    
    @IBAction func logoutClick(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "user")
        UserDefaults.standard.synchronize()
        let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
         let GoSignin = self.storyboard?.instantiateViewController(withIdentifier: "SignIn") as! signUpVC
        do {
            
            try Auth.auth().signOut()
            delegate.window?.rootViewController = GoSignin
            delegate.rememberLogin()
        } catch  {
            print("Error")
        }
      
      
        
    }
    

}

