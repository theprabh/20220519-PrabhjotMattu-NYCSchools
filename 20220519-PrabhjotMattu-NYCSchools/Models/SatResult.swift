//
//  SatResults.swift
//  20220519-PrabhjotMattu-NYCSchools
//
//  Created by Prabhjot Mattu on 5/19/22.
//

import Foundation

struct SatResult: Identifiable, Decodable {
    var id = UUID()
    var dbn: String
    var schoolName: String?
    var reading: String?
    var math: String?
    var writing: String?
    
    init(dbn: String){
        self.dbn = dbn
    }
    
    enum CodingKeys: String, CodingKey {
        case dbn
        case schoolName = "school_name"
        case reading = "sat_critical_reading_avg_score"
        case math = "sat_math_avg_score"
        case writing = "sat_writing_avg_score"
    }
}
