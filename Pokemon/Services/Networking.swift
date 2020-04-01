//
//  Networking.swift
//  Pokemon
//
//  Created by BoFu on 30/03/2020.
//  Copyright © 2020 BoFu. All rights reserved.
//

import Foundation

struct Networking {
    
    func getData<T: Decodable>(url: URL, completion: @escaping (T?) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                
                print(error)
                completion(nil)
                
            } else if let loadedData = data {

                do {
                    let okLoadedData = try JSONDecoder().decode(T.self, from: loadedData)
                    completion(okLoadedData)
                } catch let error{
                    print(error)
                    completion(nil)
                }

            }
            
        }.resume()
    }
}
