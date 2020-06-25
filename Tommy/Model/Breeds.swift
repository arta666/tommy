//
//  Breeds.swift
//  Tommy
//
//  Created by Arman on 25/06/2020.
//  Copyright © 2020 Arman. All rights reserved.
//

import Foundation

struct Breeds : Codable {
    let id : String
    let name : String
    let temperament : String?
    let life_span : String?
    let alt_names : String?
    let experimental : Int?
    let hairless : Int?
    let hypoallergenic : Int?
    let natural : Int?
    let origin : String?
    let rare : Int?
    let reference_image_id : String?
    let rex : Int?
    let short_legs : Int?
    let suppressed_tail : Int?
    let weight_imperial : String?
    let wikipedia_url : String?
}
