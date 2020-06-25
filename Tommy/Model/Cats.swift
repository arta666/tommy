//
//  Cats.swift
//  Tommy
//
//  Created by Arman on 25/06/2020.
//  Copyright © 2020 Arman. All rights reserved.
//

import Foundation
struct Cats : Codable {
    let id : String
    let url : String
    let breeds : [Breeds]?
    let categories : [Category]?
    let height:Int?
    let width:Int?
}
