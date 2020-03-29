//
//  DataModel.swift
//  Table Eaxample
//
//  Created by Prashant on 20/03/20.
//  Copyright © 2020 Prashant. All rights reserved.
//

import UIKit

class DataModel: NSObject {
    var sectionTitle: String
    var subcellData: [String]
    var isExpanded: Bool
    init(sectionTitle: String,subcellData: [String],isExpanded: Bool) {
        self.sectionTitle = sectionTitle
        self.subcellData = subcellData
        self.isExpanded = isExpanded
    }

}

struct DataModelStruct {
    var sectionTitle: String
    var subcellData: [String]
    var isExpanded: Bool
    init(sectionTitle: String,subcellData: [String],isExpanded: Bool) {
        self.sectionTitle = sectionTitle
        self.subcellData = subcellData
        self.isExpanded = isExpanded
    }
    
}

