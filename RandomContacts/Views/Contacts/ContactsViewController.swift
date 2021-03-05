//
//  ContactsViewController.swift
//  RandomContacts
//
//  Created by Ростислав Ермаченков on 05.03.2021.
//

import Foundation
import UIKit

class ContactsViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var usersViewModel = UsersViewModel.init(cells: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let network = ContactsService()
        
        network.getUsers { (vm) in
            self.usersViewModel = vm
        }
    }

}

extension ContactsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersViewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReposCell.reuseId, for: indexPath) as! ReposCell
        let cellViewModel = usersViewModel.cells[indexPath.row]
        cell.set(viewModel: cellViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cellViewModel = usersViewModel.cells[indexPath.row]
        
        let storyboard = UIStoryboard(name: "ContactScene", bundle: nil)
        guard let repoViewController = storyboard.instantiateViewController(identifier: "ContactViewController") as? ContactViewController else { return }
        
//        repoViewController.repoDescription = cellViewModel.description ?? "s"
//        repoViewController.repoFullName = cellViewModel.fullName
//        repoViewController.repoOwnerLogin = cellViewModel.ownerLogin
        
        navigationController?.pushViewController(repoViewController, animated: true)
    }
}
