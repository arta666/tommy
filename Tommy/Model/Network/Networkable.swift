//
//  Networkabl.swift
//  Tommy
//
//  Created by Arman on 25/06/2020.
//  Copyright © 2020 Arman. All rights reserved.
//

import Foundation
import Moya
protocol Networkable {
    
    var provider: MoyaProvider<TommyApi> { get }
    
    func search(page:Int,completion: @escaping ([Cats]?, Error?) -> ())
}
