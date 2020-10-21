//
//  DetailContactViewController.swift
//  TableViewHomework
//
//  Created by Ruslan Khanov on 21.10.2020.
//  Copyright © 2020 Ruslan Khanov. All rights reserved.
//

import UIKit

class DetailContactViewController: UIViewController {
    
    var contact = Contact()
    
    @IBOutlet var iconView: ContactIconView! {
        didSet {
            iconView.layer.cornerRadius = 50.0
            iconView.clipsToBounds = true
        }
    }
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var phoneNumberView: ContactPhoneNumberView! {
        didSet {
            phoneNumberView.layer.cornerRadius = 10.0
            phoneNumberView.clipsToBounds = true
        }
    }
    @IBOutlet var messageButton: UIButton! {
        didSet {
            messageButton.layer.cornerRadius = 10.0
            messageButton.clipsToBounds = true
        }
    }
    @IBOutlet var callButton: UIButton! {
        didSet {
            callButton.layer.cornerRadius = 10.0
            callButton.clipsToBounds = true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        iconView.iconLabel.text = "\(String(contact.lastname.first!))\(String(contact.firstname.first!))"
        nameLabel.text = contact.lastname + " " + contact.firstname
        phoneNumberView.phoneNumberLabel.text = contact.phoneNumber
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
