//
//  Network.swift
//  20220519-PrabhjotMattu-NYCSchools
//
//  Created by Prabhjot Mattu on 5/19/22.
//

import Foundation

class Network: ObservableObject {
    @Published var schools: [School] = []
    @Published var satResults: [SatResult] = []
    
    // Generic function to get Data from a URL
    func getData(urlString: String) async throws -> Data {
        // Confirm URL is defined
        guard let url = URL(string: urlString) else {
            fatalError("No URL")
        }
        
        let urlRequest = URLRequest(url: url)
        let(data, response) = try await URLSession.shared.data(for: urlRequest)
        
        // Throw error if data request is not successful
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error getting data")
        }
        
        return data
    }
    
    // Function to get and decode School JSON data from provided URL
    func getSchools() async throws {
        do {
            let data = try await getData(urlString: "https://data.cityofnewyork.us/resource/s3k6-pzi2.json")
            // If response sucessful decode JSON and asign to schools
            DispatchQueue.main.async {
                do {
                    let schools = try JSONDecoder().decode([School].self, from: data)
                    self.schools = schools
                    self.schools.sort { a, b in
                       return a.schoolName < b.schoolName
                    }
                } catch let error {
                    print("Error decoding JSON", error)
                }
            }
        } catch {
            print("Error getting data", error)
        }
    }
    
    // Function to get and decode SAT Results JSON data from provided URL
    func getSatResults() async throws {
        do {
            let data = try await getData(urlString: "https://data.cityofnewyork.us/resource/f9bf-2cp4.json")
            // If response sucessful decode JSON and asign to satResults
            DispatchQueue.main.async {
                do {
                    let satResults = try JSONDecoder().decode([SatResult].self, from: data)
                    self.satResults = satResults
                } catch let error {
                    print("Error decoding JSON", error)
                }
            }
        } catch {
            print("Error getting data", error)
        }
        
        
    }
}
