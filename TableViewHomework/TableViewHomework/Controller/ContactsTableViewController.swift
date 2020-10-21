//
//  ContactsTableViewController.swift
//  TableViewHomework
//
//  Created by Ruslan Khanov on 20.10.2020.
//  Copyright © 2020 Ruslan Khanov. All rights reserved.
//

import UIKit

class ContactsTableViewController: UITableViewController {
    
    var contacts = [Contact]()
    
    private func fillContacts() {
        contacts = [Contact(firstname: "Ruslan", lastname: "Khanov", phoneNumber: "+7 (888) 888-88-88"),
                    Contact(firstname: "Robert", lastname: "Gadelshin", phoneNumber: "+7 (222) 222-22-22"),
                    Contact(firstname: "Igor", lastname: "Mezin", phoneNumber: "+7 (999) 999-99-99"),
                    Contact(firstname: "Ilshat", lastname: "Mukhamedyarov", phoneNumber: "+7 (000) 000-00-00"),
                    Contact(firstname: "Ildar", lastname: "Zalyaliev", phoneNumber: "+7 (111) 111-11-11"),
                    Contact(firstname: "Idel", lastname: "Shakirov", phoneNumber: "+7 (333) 333-33-33"),
                    Contact(firstname: "Mikhail", lastname: "Mukhamatkhanov", phoneNumber: "+7 (444) 444-44-44"),
                    Contact(firstname: "Marat", lastname: "Maratov", phoneNumber: "+7 (555) 555-55-55"),
                    Contact(firstname: "Masha", lastname: "Mikhailova", phoneNumber: "+7 (666) 666-66-66"),
                    Contact(firstname: "Svetlana", lastname: "Safonova", phoneNumber: "+7 (777) 777-77-77"),
                    Contact(firstname: "Sanya", lastname: "Akhmerov", phoneNumber: "+7 (010) 101-01-01"),
                    Contact(firstname: "Azamat", lastname: "Akhmaev", phoneNumber: "+7 (111) 000-10-10")]
        
        contacts.sort(by: {$0.firstname < $1.firstname})
    }
    
    private struct SectionData {
        let contacts: [Contact]
    }
    
    private var sectionsData: [SectionData]?
    
    private func loadData() {
        sectionsData = []
        
        var contactsBeginWithCurrentLetter = [Contact]()
        for i in 0...contacts.count - 1 {
            contactsBeginWithCurrentLetter.append(contacts[i])
            
            if i != contacts.count - 1 {
                if contacts[i].firstname.first != contacts[i + 1].firstname.first {
                    sectionsData?.append(SectionData.init(contacts: contactsBeginWithCurrentLetter))
                    contactsBeginWithCurrentLetter = []
                }
            } else {
                sectionsData?.append(SectionData.init(contacts: contactsBeginWithCurrentLetter))
            }
        }
    }
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillContacts()
        loadData()
        
        tableView.tableFooterView = UIView()
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsData?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionData = sectionsData?[section] else {
            return 0
        }
        
        return sectionData.contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellData = sectionsData?[indexPath.section] else {
            fatalError("Attempt to get data while it is not loaded")
        }
        
        let cellIdentifier = "contactCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        let lastName = cellData.contacts[indexPath.row].lastname
        let firstName = cellData.contacts[indexPath.row].firstname
        
        cell.textLabel?.attributedText = getFullNameAttributedText(firstname: firstName, lastname: lastName)
        
        return  cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let firstLetter = sectionsData?[section].contacts[0].firstname.first {
            return String(firstLetter)
        }
        return ""
    }
    
    // MARK: - Configure seque
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                guard let cellData = sectionsData?[indexPath.section] else {
                    fatalError("Attempt to get data while it is not loaded")
                }
                
                let destinationController = segue.destination as! DetailContactViewController
                destinationController.contact = cellData.contacts[indexPath.row]
            }
        }
    }
    
    // MARK: - Helpers
    func getFullNameAttributedText(firstname: String, lastname: String) -> NSMutableAttributedString {
        let attributeForLastName = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular)]
        let attributeForFirstName = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .semibold)]
        
        let attributedLastNameText = NSMutableAttributedString(string: lastname, attributes: attributeForLastName)
        let attributedFirstNameText = NSAttributedString(string: " " + firstname, attributes: attributeForFirstName)
        
        attributedLastNameText.append(attributedFirstNameText)
        
        return attributedLastNameText
    }

}
