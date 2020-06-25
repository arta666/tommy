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
    
//    func getPosts(completion: @escaping ([Post]?, Error?) -> ()) {
//        provider.request(.getPost()) { (response) in
//            switch response.result {
//            case .failure(let error):
//                completion(nil, error)
//            case .success(let value):
//                let decoder = JSONDecoder()
//                do {
//                    let posts = try decoder.decode([Post].self, from: value.data)
//                    completion(posts, nil)
//                } catch let error {
//                    completion(nil, error)
//                }
//            }
//        }
//    }
//
//    func getPostWith(id: Int, completion: @escaping (Post?, Error?) -> ()) {
//        provider.request(.getPostWith(id: id)) { (response) in
//            switch response.result {
//            case .failure(let error):
//                completion(nil, error)
//            case .success(let value):
//                let decoder = JSONDecoder()
//                do {
//                    let post = try decoder.decode(Post.self, from: value.data)
//                    completion(post, nil)
//                } catch let error {
//                    completion(nil, error)
//                }
//            }
//        }
//    }
//
//    func createPosth(post: Post, completion: @escaping (Post?, Error?) -> ()) {
//        provider.request(.createPost(post: post)) { (response) in
//            switch response.result {
//            case .failure(let error):
//                completion(nil, error)
//            case .success(let value):
//                let decoder = JSONDecoder()
//                do {
//                    let post = try decoder.decode(Post.self, from: value.data)
//                    completion(post, nil)
//                } catch let error {
//                    completion(nil, error)
//                }
//            }
//        }
//    }
}
