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
    var subcellData: [SubCellDataModel]
    var isExpanded: Bool
    init(sectionTitle: String,subcellData: [SubCellDataModel],isExpanded: Bool, sectionId: Int) {
        self.sectionTitle = sectionTitle
        self.subcellData = subcellData
        self.isExpanded = isExpanded
        self.sectionId = sectionId
    }

}

struct DataModelStruct {
    var sectionId: Int
    var sectionTitle: String
    var subcellData: [SubCellDataModel]
    var isExpanded: Bool
    init(sectionTitle: String,subcellData: [SubCellDataModel],isExpanded: Bool, sectionId: Int) {
        self.sectionTitle = sectionTitle
        self.subcellData = subcellData
        self.isExpanded = isExpanded
        self.sectionId = sectionId
    }
}

class SubCellDataModel: NSObject{
    var id: Int
    var data: String
    init(id: Int, data: String) {
        self.id = id
        self.data = data
    }
}






