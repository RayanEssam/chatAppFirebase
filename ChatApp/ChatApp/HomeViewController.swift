//
//  HomeViewController.swift
//  ChatApp
//
//  Created by Rayan Taj on 07/12/2021.
//

import UIKit
import Firebase

class HomeViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    var arrayOfUsers : [User] = []
    let db = Firestore.firestore()
    @IBOutlet var homeTabelView: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayOfUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let UserChatCell = tableView.dequeueReusableCell(withIdentifier: "UserCellTableViewCell") as! UserCellTableViewCell
        
        UserChatCell.name.text = arrayOfUsers[indexPath.row].name
        
        return UserChatCell
        
        
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Go to Chat
        
        let  chatVC = storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        
        chatVC.modalPresentationStyle = .fullScreen
        
        chatVC.name = arrayOfUsers[indexPath.row].name
        chatVC.id = arrayOfUsers[indexPath.row].uid
        
        navigationController?.pushViewController(chatVC, animated: true)
        
        
        
    }
    
    
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUsersFromFireBase()
        
    }
    
    func getUsersFromFireBase(){
        
        db.collection("Users").getDocuments(){ (querySnapshot, err) in
           
            
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {

                    
                    let name : String = document.get("Name") as! String
                    let uid :String = document.get("ID") as! String
                   
                    if uid == Auth.auth().currentUser?.uid {
                        
                    }else{
                        
                        self.arrayOfUsers.append(User(name: name, uid: uid))

                    }
                    
                    
                }
                
                self.homeTabelView.reloadData()
            }
            
            
        }
        
    }
    
    @IBAction func reloadButton(_ sender: Any) {
        
        arrayOfUsers.removeAll()
        getUsersFromFireBase()
    }
    
    @IBAction func signOutButtonClicked(_ sender: Any) {
        
        
        
        do {
            try Auth.auth().signOut()
            self.dismiss(animated: true, completion: nil)
        } catch  {
            print("Errrroooor")
            
        }
        
        
    }
    
    
    
}


struct User {
    
    var name : String
    var uid : String
    
}
