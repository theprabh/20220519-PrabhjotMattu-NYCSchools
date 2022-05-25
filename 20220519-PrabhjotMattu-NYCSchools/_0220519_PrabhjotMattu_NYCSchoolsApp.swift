//
//  _0220519_PrabhjotMattu_NYCSchoolsApp.swift
//  20220519-PrabhjotMattu-NYCSchools
//
//  Created by Prabhjot Mattu on 5/19/22.
//

import SwiftUI

@main
struct _0220519_PrabhjotMattu_NYCSchoolsApp: App {
    var network = Network()
    
    var body: some Scene {
        WindowGroup {
            SchoolListView()
                .environmentObject(network)
        }
    }
}
