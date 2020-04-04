//
//  DataModel.swift
//  Table Eaxample
//
//  Created by Prashant on 20/03/20.
//  Copyright © 2020 Prashant. All rights reserved.
//

import UIKit

class DataModel: NSObject {
    var sectionId: Int
    var sectionTitle: String
    var subcellData: [String]
    var isExpanded: Bool
    init(sectionTitle: String,subcellData: [String],isExpanded: Bool, sectionId: Int) {
        self.sectionTitle = sectionTitle
        self.subcellData = subcellData
        self.isExpanded = isExpanded
        self.sectionId = sectionId
    }

}

struct DataModelStruct {
    var sectionId: Int
    var sectionTitle: String
    var subcellData: [String]
    var isExpanded: Bool
    init(sectionTitle: String,subcellData: [String],isExpanded: Bool, sectionId: Int) {
        self.sectionTitle = sectionTitle
        self.subcellData = subcellData
        self.isExpanded = isExpanded
        self.sectionId = sectionId
    }
    
}

