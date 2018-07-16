//
//  SecondViewController.swift
//  Firebase(exam)
//
//  Created by Yusuf DEMİRKOPARAN on 4.07.2018.
//  Copyright © 2018 Yusuf DEMİRKOPARAN. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class uploadVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var uploadİmage: UIImageView!
    
    @IBOutlet weak var commentText: UITextView!
    
    var uuid = NSUUID().uuidString
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uploadİmage.isUserInteractionEnabled = true
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(choosePhoto))
        uploadİmage.addGestureRecognizer(recognizer)

    }

    @IBAction func postClicked(_ sender: Any) {
        
        
        
        let mediaFolder =  Storage.storage().reference().child("media")
        
        if let data = UIImageJPEGRepresentation(uploadİmage.image!, 0.5) {
            
            let mediaImageRef = mediaFolder.child("\(uuid).jpg")
            mediaImageRef.putData(data, metadata: nil) { (metadata, error) in
                if  error != nil {
                    let alert = UIAlertController(title: "error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    let okButton = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                } else {
                    mediaImageRef.downloadURL(completion: { (url, error) in
                        if  error != nil {
                            let alert = UIAlertController(title: "error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                            let okButton = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)
                            alert.addAction(okButton)
                            self.present(alert, animated: true, completion: nil)
                            
                        }else {
                            
                            let post = ["image" : url!.absoluteString ,
                                        "postedby" : Auth.auth().currentUser?.email! ,
                                        "uuid" : self.uuid ,
                                        "posttex" : self.commentText.text  ] as [String : Any]
                            
                            Database.database().reference().child("user").child((Auth.auth().currentUser?.uid)!).child("post").childByAutoId().setValue(post)
                            
                            self.uploadİmage.image = UIImage(named: "Group")
                            self.commentText.text = ""
                            self.tabBarController?.selectedIndex = 0
                            
                        }
                        
                    })
                    
                }
            }
        }
        
        
      
    }
    
    
    @objc func choosePhoto()  {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)


    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        uploadİmage.image = info[UIImagePickerControllerEditedImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

