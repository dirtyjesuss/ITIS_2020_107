//
//  Contact.swift
//  TableViewHomework
//
//  Created by Ruslan Khanov on 20.10.2020.
//  Copyright © 2020 Ruslan Khanov. All rights reserved.
//

import Foundation

class Contact {
    private(set) var firstname: String
    private(set) var lastname: String
    private(set) var phoneNumber: String
    
    init(firstname: String, lastname: String, phoneNumber: String) {
        self.firstname = firstname
        self.lastname = lastname
        self.phoneNumber = phoneNumber
    }
    
    convenience init() {
        self.init(firstname: "", lastname: "", phoneNumber: "")
    }
}
