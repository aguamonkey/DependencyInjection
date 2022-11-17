//
//  APICaller.swift
//  APIKit
//
//  Created by TCH Developer on 17/11/2022.
//

import Foundation

// Fetches collection of course names

public class APICaller {
    // shared because theres no need to be multiple instances
    public static let shared = APICaller()
    
    // private initialiser
    
    private init() {}
    
    // Signature of this function
    public func fetchCourseNames(completion: @escaping ([String]) -> Void) {
        guard let url = URL(string: "https://iosacademy.io/api/v1/courses/index.php") else {
            // If we don't have a valid URL we are going to return an empty collection
            completion([])
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                //If we don't have data we will return an empty collection
                completion([])
                return
            }
            // Decode the JSON file
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String: String]] else {
                    completion([])
                    return
                }
                
                let names = json.compactMap({ $0["name"] })
                print(names)
                completion(names)
                
            } catch {
                completion([])
            }
        }
        // How we kick off our API call
        task.resume()
    }
}
