//
//  ChatViewController.swift
//  ChatApp
//
//  Created by Rayan Taj on 07/12/2021.
//

import UIKit
import Firebase

class ChatViewController: UIViewController, UITableViewDelegate , UITableViewDataSource {
    
    var name = ""
    var id = ""
    var arrayOfMessages : [Message] = []
    let db = Firestore.firestore()

    @IBOutlet var messageTextField: UITextField!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfMessages.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chatTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell") as! ChatTableViewCell
        
        
        chatTableViewCell.message.text = arrayOfMessages[indexPath.row].message
        
        let currentUID = Auth.auth().currentUser?.uid
        
        
        if  currentUID == arrayOfMessages[indexPath.row].sender {
            
            chatTableViewCell.userID.text = arrayOfMessages[indexPath.row].sender
        }
        
//        chatTableViewCell.userID.text = "123"
        
        
        return chatTableViewCell
        
    }
    
    
    
    
    @IBAction func sendButtonClicked(_ sender: Any) {
        sendMessage()
    }
    
    
    func listenForChanges()  {
        let currentUID = Auth.auth().currentUser?.uid

        let collectionRefrence = db.collection("Users").document(self.id).collection("Messages").document("\(currentUID!)").collection("msg")
            
        collectionRefrence.order(by: "timeStamp").addSnapshotListener {
            
            documentSnapshot, error in
                
                  guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                  }
            self.arrayOfMessages.removeAll()
            
            for item in documentSnapshot!.documents {

                let sender = item.get("sender")
                let message = item.get("content") as! String
                
                
                self.arrayOfMessages.append(Message(sender: sender as! String , message: message as! String ))
            }
      
            self.tableView.reloadData()
            
            }
        
        
  
        
    }
    
    
    func sendMessage(){
        let currentUID = Auth.auth().currentUser?.uid
        
        let message = [ "sender" : "\(currentUID)" ,
            "content":"\(messageTextField.text!)", "timeStamp" : Date()] as [String : Any]
        
    
        
        db.collection("Users").document("\(currentUID!)").collection("Messages").document(self.id).collection("msg").document()
            .setData(message)
        
        
        db.collection("Users").document("\(self.id)").collection("Messages").document("\(currentUID!)").collection("msg").document()
            .setData(message)
        

        
    }
    
    

    

    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()


        listenForChanges()
        
        
    }
    

  

}


struct Message {
    
    var sender : String
    var message : String
}
