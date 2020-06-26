//
//  NetworkManager.swift
//  Tommy
//
//  Created by Arman on 25/06/2020.
//  Copyright © 2020 Arman. All rights reserved.
//
import Moya
class NetworkManager: Networkable {
    
    var provider = MoyaProvider<TommyApi>(plugins: [NetworkLoggerPlugin()])
    
    func search(page:Int,completion: @escaping ([Cats]?, Error?) -> ()) {
        provider.request(.getCats(page: page)) { (response) in
            switch response {
              case .failure(let error):
                  completion(nil, error)
              case .success(let value):
                  let decoder = JSONDecoder()
                  do {
                      let posts = try decoder.decode([Cats].self, from: value.data)
                      completion(posts, nil)
                  } catch let error {
                      completion(nil, error)
                  }
              }
          }
    }
    

}
