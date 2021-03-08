//
//  ContactViewController.swift
//  RandomContacts
//
//  Created by Ростислав Ермаченков on 05.03.2021.
//

import Foundation
import UIKit
import MessageUI

class ContactViewController: UIViewController, UINavigationControllerDelegate {
    
    var name = ""
    var surname = ""
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
        
        surnameLabel.text = surname
        nameLabel.text = name
        phoneLabel.text = phone
        emailLabel.text = email
        imageView.set(imageURL: imageUrlString)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))

        self.imageView.addGestureRecognizer(tapGestureRecognizer)
        self.imageView.isUserInteractionEnabled = true
        
    }
    
    @objc func imageViewTapped(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            
            print("sddssd")
            
            let storyboard = UIStoryboard(name: "ContactPhotoScene", bundle: nil)
            guard let contactPhotoViewController = storyboard.instantiateViewController(identifier: "ContactPhotoViewController") as? ContactPhotoViewController else { return }
            
            contactPhotoViewController.imageUrlString = imageUrlString
            
            present(contactPhotoViewController, animated: true)
        }
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
        
        if MFMessageComposeViewController.canSendText() {
            let messageComposeViewController = MFMessageComposeViewController()
            messageComposeViewController.recipients = [phone]
            messageComposeViewController.delegate = self
            messageComposeViewController.messageComposeDelegate = self
            present(messageComposeViewController, animated: true)
        }
    }
}

extension ContactViewController: MFMessageComposeViewControllerDelegate {
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        dismiss(animated: true)
    }
}
