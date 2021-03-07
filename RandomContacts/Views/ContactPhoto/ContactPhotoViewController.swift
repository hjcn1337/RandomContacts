//
//  ContactPhotoViewController.swift
//  RandomContacts
//
//  Created by Ростислав Ермаченков on 07.03.2021.
//

import Foundation
import UIKit

class ContactPhotoViewController: UIViewController {
    
    var imageUrlString = ""
    
    @IBOutlet weak var imageView: WebImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.set(imageURL: imageUrlString)
    }
}

