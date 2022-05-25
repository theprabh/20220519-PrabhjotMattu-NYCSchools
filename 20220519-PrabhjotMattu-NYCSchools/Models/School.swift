//
//  School.swift
//  20220519-PrabhjotMattu-NYCSchools
//
//  Created by Prabhjot Mattu on 5/19/22.
//

import Foundation

struct School: Identifiable, Decodable {
    var id = UUID()
    var dbn: String
    var schoolName: String
    var overviewParagraph: String
    var phoneNumber: String
    var faxNumber: String?
    var schoolEmail: String?
    var website: String
    var address: String
    var city: String
    var zip: String
    
    enum CodingKeys: String, CodingKey {
        case dbn
        case schoolName = "school_name"
        case overviewParagraph = "overview_paragraph"
        case phoneNumber = "phone_number"
        case faxNumber = "fax_number"
        case schoolEmail = "school_email"
        case website
        case address = "primary_address_line_1"
        case city
        case zip
    }
    
}
