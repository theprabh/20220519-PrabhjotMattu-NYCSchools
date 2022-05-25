//
//  SchoolListView.swift
//  20220519-PrabhjotMattu-NYCSchools
//
//  Created by Prabhjot Mattu on 5/19/22.
//

import SwiftUI

struct SchoolListView: View {
    @EnvironmentObject var network: Network
    @State var isPerformingTask = true
    @State var searchText = ""
    
    var searchResults: [School] {
        if searchText.isEmpty {
            return network.schools
        } else {
            return network.schools.filter { school in
                return school.schoolName.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var sections: [String] {
        var sectionSet: Set<String> = []
        for school in network.schools {
            if let char = school.schoolName.first {
                sectionSet.insert(String(char))
            }
        }
        print(sectionSet)
        return Array(sectionSet)
    }
    
    var body: some View {
        NavigationView{
            ScrollView {
                // Search Bar
                Text("")
                    .searchable(text: $searchText)
                ZStack {
                    // Show loading indicator while getting schools
                    if isPerformingTask {
                        ProgressView(value: 0.75)
                            .progressViewStyle(CircularProgressViewStyle())
                    }
                    VStack(alignment: .leading) {
                        ForEach(searchResults) { school in
                            NavigationLink(destination: SchoolDetailView(school: school).environmentObject(network)) {
                                VStack(alignment: .leading) {
                                    Text(school.schoolName)
                                        .foregroundColor(Color.primary)
                                        .textSelection(.enabled)
                                        .font(.headline)
                                        .multilineTextAlignment(.leading)
                                        .padding([.bottom, .top], 8)
                                    Divider()
                                }
                                .frame(alignment: .leading)
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Schools")
            .toolbar {
                // Refresh button that fetches the data again
                Button {
                    isPerformingTask = true
                    Task {
                        do {
                            try await network.getSchools()
                            isPerformingTask = false
                        } catch {
                            print("Error getting schools")
                        }
                    }
                } label: {
                    Image(systemName: "arrow.counterclockwise")
                }
            }
        }
        .navigationViewStyle(.stack)
        .task {
            do {
                try await network.getSchools()
                isPerformingTask = false
            } catch {
                print("Error getting schools", error)
            }
        }
    }
}

struct SchoolListView_Previews: PreviewProvider {
    static var previews: some View {
        SchoolListView()
            .environmentObject(Network())
    }
}
