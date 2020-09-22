//
//  Categories.swift
//  Collection View Example
//
//  Created by Amal Joshy on 22/09/20.
//  Copyright © 2020 Amal Joshy. All rights reserved.
//

import Foundation

struct categories: Codable {
    var category_id: String = " "
    var name: String = " "
    var image: String = " "
    var parent_id : String = " "
    var top : String = " "
    var subcategory : [String] = [""]
}
