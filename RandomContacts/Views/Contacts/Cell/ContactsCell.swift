//
//  UsersCell.swift
//  RandomContacts
//
//  Created by Ростислав Ермаченков on 05.03.2021.
//

import Foundation
import UIKit

protocol ContactsCellViewModel {
    var imageUrlString: String { get }
    var title: String { get }
    var name: String { get }
    var surname: String { get }
    var phone: String { get }
    var email: String { get }
}


class ContactsCell: UITableViewCell {
    
    static let reuseId = "ContactsCell"
    
    let cellView: UIView = {
       let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()

    let contactImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = #colorLiteral(red: 0.8234507442, green: 0.3115251064, blue: 0.3296223879, alpha: 1)
        return imageView
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
        
        overlayFirstLayer()
        overlayCardView()
    }
    
    private func overlayCardView() {
        cellView.addSubview(nameLabel)
        cellView.addSubview(contactImageView)
        
        nameLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 10).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        contactImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        contactImageView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10).isActive = true
        contactImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        contactImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
    }
    
    override func prepareForReuse() {
        contactImageView.set(imageURL: nil)
    }
    
     private func overlayFirstLayer() {
        if #available(iOS 14.0, *) {
            contentView.addSubview(cellView)
        } else {
            addSubview(cellView)
        }
    
        cellView.fillSuperview(padding: Constants.cellInsets)
    }
    
    func set(viewModel: ContactsCellViewModel) {
        
        let fullName = viewModel.title + " " + viewModel.name + " " + viewModel.surname
        
        contactImageView.set(imageURL: viewModel.imageUrlString)
        nameLabel.text = fullName
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
