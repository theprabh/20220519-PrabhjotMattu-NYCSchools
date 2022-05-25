//
//  SchoolDetailView.swift
//  20220519-PrabhjotMattu-NYCSchools
//
//  Created by Prabhjot Mattu on 5/19/22.
//

import SwiftUI

struct SchoolDetailView: View {
    @EnvironmentObject var network: Network
    let school: School
    @State var satResult = SatResult(dbn: "")
    @State var isAnimating = true
    
    var body: some View {
        ZStack {
            // Show loading indicator while getting SAT results
            if isAnimating {
                ProgressView(value: 0.75)
                    .progressViewStyle(CircularProgressViewStyle())
            }
            Form {
                Section(header: Text("School Info").foregroundColor(Color.primary)) {
                    Text("\(school.address), \(school.city), NY \(school.zip)")
                        .foregroundColor(Color.primary)
                        .textSelection(.enabled)
                    if let url = URL(string: "tel:\(school.phoneNumber)") {
                        Link("Phone: \(school.phoneNumber)", destination: url)
                    }
                    if let faxNum = school.faxNumber {
                        Text("Fax: \(faxNum)").foregroundColor(Color.primary)
                    }
                    Text(school.overviewParagraph).foregroundColor(Color.primary)
                }
                Section(header: Text("SAT Scores").foregroundColor(Color.primary)) {
                    if satResult.dbn.isEmpty {
                        Text("Test results not available").foregroundColor(Color.primary)
                    } else {
                        Text("Math: \(satResult.math ?? "n/a")").foregroundColor(Color.primary)
                        Text("Reading: \(satResult.reading ?? "n/a")").foregroundColor(Color.primary)
                        Text("Writing: \(satResult.writing ?? "n/a")").foregroundColor(Color.primary)
                    }
                }
            }
        }
        .navigationTitle(school.schoolName)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            do {
                // Await HTTP response and then navigate list of SAT results to find a match
                try await network.getSatResults()
                for result in network.satResults {
                    if result.dbn == self.school.dbn {
                        satResult = result
                        return
                    }
                }
                isAnimating = false
            } catch {
                print("Error getting SAT results", error)
            }
        }
    }
}
