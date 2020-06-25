//
//  Photo+Extensions.swift
//  Tommy
//
//  Created by Arman on 25/06/2020.
//  Copyright © 2020 Arman. All rights reserved.
//

import Foundation
import CoreData

extension Photo {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        creationDate = Date()
    }
}
