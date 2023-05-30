//
//  ImageDownloader.swift
//  ComprendreLesAPI
//
//  Created by Mathieu @theunknowman_80 on Twitter 29/05/2023.
//

//This file, on the other hand, allows downloading images associated with randomly generated profiles asynchronously. This means that even if the processing takes some time, the user may not necessarily notice it and will enjoy a relatively smooth experience. By using a function like this, you can retrieve an image from a String-based URL and then integrate it into a UIImageView, for example.

import Foundation


class ImageDownloader {
    static let shared = ImageDownloader()
    
    func fromUrlString(_ urlString: String, completion: @escaping((Data?) -> Void)) {
        guard let url = URL(string: urlString) else {completion(nil); return}
        URLSession.shared.dataTask(with: url) { d, _, _ in
            DispatchQueue.main.async {
                completion(d)
            }
        }.resume()
    }
}
