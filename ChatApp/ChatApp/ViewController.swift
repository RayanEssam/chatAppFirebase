//
//  ViewController.swift
//  ChatApp
//
//  Created by Rayan Taj on 07/12/2021.
//

import UIKit
import Firebase


class ViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
//        if Auth.auth().currentUser. {
//
//
//        }
    }
    @IBAction func signInButton(_ sender: Any) {
print("Helloooo")
        if Auth.auth().currentUser?.uid == nil {

            Auth.auth().signInAnonymously { authResult, error in
                    
                if error == nil {
                    
                    guard let user = authResult?.user else { return }
//                    let isAnonymous = user.isAnonymous  // true
                    let uid = user.uid
                    
                    let dataUser = ["Name":"user",
                                    "ID":"\(uid)",]
                    print("WORKING ")
                    self.db.collection("Users").document(uid).setData(dataUser)
                    
//                    let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as!  HomeViewController
//                    homeVC.modalPresentationStyle = .fullScreen
//                    self.present(homeVC, animated: true, completion: nil)
//
                    self.performSegue(withIdentifier: "seID", sender: self)
                    
                }
                
                
            }
            
        }else{
            print("Hello")

            let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as!  HomeViewController
            
            homeVC.modalPresentationStyle = .fullScreen
            
            self.present(homeVC, animated: true, completion: nil)
        }
      
        
       

        
        
        
    }
    
}

