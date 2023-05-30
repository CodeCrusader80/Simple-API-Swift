//
//  APIHelper.swift
//  ComprendreLesAPI
//
//  Created by Mathieu @theunknowman_80 29/05/2023.
//

import Foundation

//This is where it all begins. The API Helper created in this class establishes a connection to an API, which, in this case, is quite easy to use, doesn't require a key, and allows generating random users with various data obtained through a JSON data stream. Once the API Helper is set up as shown below (finding the construction logic is not very difficult in this case), go to the Gender file and create an enum with three cases: 'male', 'female', and 'noGender', as specified in the documentation. Then, to know how and which information to search for in the JSON file retrieved via the API, simply create a constant in the viewController, for example: 'let url = APIHelper.shared.getUrl(results: 1, gender: man)', and then print the 'url' to obtain a URL that returns a JSON file. Copy and paste that URL into your browser to see all the data transmitted by the API. Copy them to use later through a decoder, the function of which is displayed below and will use data that we will have to create in a third file, 'APIResult'.

class APIHelper {
    
    static let shared = APIHelper()
    
    let apiEntryPoint = "https://randomuser.me/api/"
    let results = "results"
    let gender = "gender"
    
    //Base + ? + Param1 = value1 + & + Param2 = value2 etc...
    //Créer une URL qui va faire notre requête
    
    
    func getUrl(results: Int, gender: Gender) -> URL? {
        var urlString = apiEntryPoint
        urlString += "?"
        urlString += "\(self.results)=\(results)"
        if gender != .noGender {
            urlString += "&\(self.gender)=\(gender.rawValue)"
        }
        return URL(string: urlString)
    }
    
    func performRequest(results: Int, gender: Gender, completion: @escaping (([User]) -> Void)) {
        if let url = getUrl(results: results, gender: gender) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let d = data {
                    let decoder = JSONDecoder()
                    do {
                        let results =  try decoder.decode(ApiResults.self, from: d)
                        completion(results.results)
                    } catch {
                        print(error.localizedDescription)
                }
                } else {
                    completion([])
                }
            }.resume()
        } else {
            completion ([])
        }
    }
                                                                        
}
