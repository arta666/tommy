//
//  ImageService.swift
//  Tommy
//
//  Created by Arman on 25/06/2020.
//  Copyright © 2020 Arman. All rights reserved.
//

import Foundation

class ImageService {
    
    class func request(url:URL,completion: @escaping (Data? ,Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url as URL) { (data, response, error) in
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil,error)
                }
                
                return
            }
            DispatchQueue.main.async {
                completion(data,nil)
            }
        }
        task.resume()
    }
}
