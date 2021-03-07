//
//  MessagesHelper.swift
//  RandomContacts
//
//  Created by Ростислав Ермаченков on 06.03.2021.
//

import Foundation
import MessageUI
import UIKit

class MessagesHelper {
    func createMessagesController(phone: String) -> MFMessageComposeViewController {
        if MFMessageComposeViewController.canSendText() {
            let messageComposeViewController = MFMessageComposeViewController()
            messageComposeViewController.recipients = [phone]
            return messageComposeViewController
        }
        return MFMessageComposeViewController()
    }
}
