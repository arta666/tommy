//
//  ApiClient.swift
//  Tommy
//
//  Created by Arman on 25/06/2020.
//  Copyright © 2020 Arman. All rights reserved.
//

import Moya
enum TommyApi {
    case getCats(limit: Int=30,page: Int)
}

extension TommyApi : TargetType{
    var baseURL: URL {
        return URL(string: "https://api.thecatapi.com/v1")!
    }
    var path: String {
        switch self {
        case .getCats(_, _):
            return "/images/search"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCats:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getCats(limit:let limit,page:let page):
            return .requestParameters(parameters: ["limit":limit, "page":page], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json; charset=utf-8","x-api-key" : "bc9604c0-b828-4c5a-aec9-1faedeab2bda"]
    }
    

}
