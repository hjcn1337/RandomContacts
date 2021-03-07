//
//  ContactsViewController.swift
//  RandomContacts
//
//  Created by Ростислав Ермаченков on 05.03.2021.
//

import Foundation
import UIKit

class ContactsViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let network = ContactsService()
    let coreDataManager = CoreDataManager()
    
    let activityView = UIActivityIndicatorView(style: .large)
    
    private var viewModel = ContactsViewModel()  {
        
        didSet {
            self.table.reloadData()
            self.activityView.stopAnimating()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self

        setupTable()
        
        getContacts()
    }
    
    private func getContacts() {
        showActivityIndicatory()
        let contacts = coreDataManager.getContacts()
        
        if contacts.isEmpty {
            network.getContacts { contacts in
    
                let contacts = contacts.map { contact in
                    return ContactViewModel(imageUrlString: contact.imageUrlString, title: contact.title, name: contact.name, surname: contact.surname, phone: contact.phone, email: contact.email)
                }
                
                self.viewModel = ContactsViewModel(contacts: contacts)
                
                for contact in self.viewModel.contacts {
                    self.coreDataManager.createContact(contact: contact)
                }
            }
            
        } else {
            
            let contactsViewModel = contacts.map { contact in
                return ContactViewModel(imageUrlString: contact.imageUrlString ?? "", title: contact.title ?? "", name: contact.name ?? "", surname: contact.surname ?? "", phone: contact.phone ?? "", email: contact.email ?? "")
                
            }
            self.viewModel = ContactsViewModel(contacts: contactsViewModel)
        }
        
    }
    
    private func setupTable() {
        table.register(ContactsCell.self, forCellReuseIdentifier: ContactsCell.reuseId)
    }
    
    private func showActivityIndicatory() {
        activityView.center = self.view.center
        self.view.addSubview(activityView)
        activityView.startAnimating()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        guard let searchStr = searchBar.text else { return }
        let contacts = coreDataManager.searchContacts(searchString: searchStr)
        let contactsViewModel = contacts.map { contact in
            return ContactViewModel(imageUrlString: contact.imageUrlString ?? "", title: contact.title ?? "", name: contact.name ?? "", surname: contact.surname ?? "", phone: contact.phone ?? "", email: contact.email ?? "")
            
        }
        self.viewModel = ContactsViewModel(contacts: contactsViewModel)
    
    }

}

extension ContactsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactsCell.reuseId, for: indexPath) as! ContactsCell
        let cellViewModel = viewModel.contacts[indexPath.row]
        cell.set(viewModel: cellViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cellViewModel = viewModel.contacts[indexPath.row]
        
        let storyboard = UIStoryboard(name: "ContactScene", bundle: nil)
        guard let contactViewController = storyboard.instantiateViewController(identifier: "ContactViewController") as? ContactViewController else { return }
        
        contactViewController.email = cellViewModel.email
        contactViewController.name = cellViewModel.name
        contactViewController.surname = cellViewModel.surname
        contactViewController.phone = cellViewModel.phone
        contactViewController.imageUrlString = cellViewModel.imageUrlString
        
        present(contactViewController, animated: true)
    }
}
