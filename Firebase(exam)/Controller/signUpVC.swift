//
//  singUp.swift
//  Firebase(exam)
//
//  Created by Yusuf DEMİRKOPARAN on 4.07.2018.
//  Copyright © 2018 Yusuf DEMİRKOPARAN. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
class signUp: UIViewController {

    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var passLabel: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.lightGray
       
    }

   
    @IBAction func signIn(_ sender: Any) {
        if emailLabel.text != nil && passLabel.text != nil {
            Auth.auth().signIn(withEmail: emailLabel.text!, password: passLabel.text!) { (user, error) in
                
                if error != nil {
                    let alert = UIAlertController(title: "Error", message:error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    let okButton = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                } else {
                    
                    UserDefaults.standard.set(user?.user.email!, forKey: "user")
                    UserDefaults.standard.synchronize()
                    
                    let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    delegate.rememberLogin()
                    self.performSegue(withIdentifier: "tabSegue", sender: nil)
                }
                
            }
            
        } else {
            let alert = UIAlertController(title: "Error", message: "Zorunlu Alan", preferredStyle: UIAlertControllerStyle.alert)
            let okButton = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)

        }
        
        
    }
    
    @IBAction func SignUp(_ sender: Any) {
        if emailLabel.text != nil && passLabel.text != nil {
            Auth.auth().createUser(withEmail: emailLabel.text!, password: passLabel.text!) { (user, error) in
                if error != nil {
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    let okButton = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                } else {
                    print("USER -> \(String(describing: user?.user.email))")
                    print("Succesful")
                    UserDefaults.standard.set(user?.user.email!, forKey: "user")
                    UserDefaults.standard.synchronize()
                    
                    let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    delegate.rememberLogin()
                }
            }
        } else {
            let alert = UIAlertController(title: "Error", message: "Zorunlu alan", preferredStyle: UIAlertControllerStyle.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        }
      
        }
        
        
        
    }
    

