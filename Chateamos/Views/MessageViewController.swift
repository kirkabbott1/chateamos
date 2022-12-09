//
//  MessageViewController.swift
//  Chateamos
//
//  Created by Kirk Abbott on 12/8/22.
//

import Foundation
import UIKit
import Firebase

class MessageViewController: UIViewController {

    
    lazy var scrollView: UITableView = {
        let scroll = UITableView(frame: .zero)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = .white

        scroll.dataSource = self
        scroll.register(MessageTableViewCell.self, forCellReuseIdentifier: "MessageCell")
        
        return scroll
    }()
    
    lazy var sendChat: UITextView = {
        let text = UITextView(frame: .zero)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = .systemGray6
        text.font = UIFont.systemFont(ofSize: 18)
        text.layer.cornerRadius = 20
        text.text = "Chat"
        text.isScrollEnabled = true
        text.clearsOnInsertion = true
        
        return text
    }()
    
    lazy var sendButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(MessageBtnPress), for: .touchUpInside)
        button.setTitle("Send", for: .normal)
        
        return button
        
    }()
    
    var messages: [message] = []
//    var frameView = UIView?.self
    let ref = Database.database().reference().child("messages")

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        ref.observe(.childAdded) { childBorn, arg  in
            guard let temp = childBorn.value as? [String: AnyObject] else {return}
            guard let userName = temp["username"] as? String else {return}
            guard let msg = temp["body"] as? String else {return}
            guard let timeStamp = temp["timestamp"] as? String else {return}
            guard let uid = temp["UID"] as? String else {return}
            self.messages.append(message(UID: uid, body: msg, timestamp: timeStamp, username: userName))
            self.scrollView.reloadData()
            self.scrollView.scrollToRow(at: IndexPath(row: self.messages.count - 1, section: 0), at: .bottom, animated: true)
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray6
        self.title = "Chats"
        createUI()

    }
    
    func createUI() {
        self.view.addSubview(self.scrollView)
        self.view.addSubview(self.sendChat)
        self.view.addSubview(self.sendButton)
        
        self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        self.scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        self.scrollView.bottomAnchor.constraint(equalTo: self.sendChat.topAnchor, constant: -8).isActive = true
        self.scrollView.layer.cornerRadius = 20
        
        self.sendChat.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        self.sendChat.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.sendChat.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        self.sendButton.leadingAnchor.constraint(equalTo: self.sendChat.trailingAnchor, constant: 8).isActive = true
        self.sendButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        self.sendButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        self.sendButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        self.sendButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }

}
extension MessageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as? MessageTableViewCell else { return UITableViewCell() }
        print("messages: \(messages[indexPath.row])")
        var messageBodyCenter: String = messages[indexPath.row].body
        messageBodyCenter.replace(("\""), with: "")
        messageBodyCenter.replace(";", with: "")
        messageBodyCenter.replace("\\U2019", with: "'")
        cell.isUserInteractionEnabled = false
        

        if self.messages[indexPath.row].username.lowercased().trimmingCharacters(in: .whitespaces) == "kirk" {
            cell.messageLabel.backgroundColor = .systemPink
            cell.sender.textAlignment = .right
        } else{
            cell.messageLabel.backgroundColor = .systemGray6
            cell.sender.textAlignment = .left
        }
            cell.messageLabel.text = messageBodyCenter
            cell.sender.text = self.messages[indexPath.row].username
            
        return cell

    }
    
    @objc
    func MessageBtnPress() {
        self.scrollView.reloadData()
        let DBref = Database.database().reference()
        
        guard let body = self.sendChat.text else {return}
        let uid = "435lk2hj43"
        let username = "kirk"
        let timeNow = "\(Date())"
        if body != "" || body != "Chat" {
            DBref.child("messages").child(timeNow).setValue(["UID" : uid, "body": body, "timestamp": timeNow, "username" : username])
            
        }
        
        self.sendChat.text = "Chat"
        self.sendChat.clearsOnInsertion = true
        
        if messages.count > 3 {
            self.scrollView.scrollToRow(at: IndexPath(row: messages.count-1, section: 0), at: .bottom, animated: true)
        }
    }
    
    
    
}

