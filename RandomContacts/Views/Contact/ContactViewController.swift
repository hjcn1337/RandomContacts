//
//  ContactViewController.swift
//  RandomContacts
//
//  Created by Ростислав Ермаченков on 05.03.2021.
//

import Foundation
import UIKit

class ContactViewController: UIViewController {
    
    var name = ""
    var email = ""
    var phone = ""
    var imageUrlString = ""
    
    @IBOutlet weak var imageView: WebImageView!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        surnameLabel.text = name
        nameLabel.text = name
        phoneLabel.text = phone
        emailLabel.text = email
        imageView.set(imageURL: imageUrlString)
        
    }
    
    @IBAction func callPhoneButtonPressed(_ sender: Any) {
        if let url = URL(string: "tel://\(phone)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    @IBAction func sendMessageButtonPressed(_ sender: Any) {
        let messagesHelper = MessagesHelper()
        let sendMessageVC = messagesHelper.createMessagesController(phone: phone)
        present(sendMessageVC, animated: true, completion: nil)
    }
}
