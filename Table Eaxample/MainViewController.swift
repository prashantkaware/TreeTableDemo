//
//  MainViewController.swift
//  Table Eaxample
//
//  Created by Prashant on 04/04/20.
//  Copyright © 2020 Prashant. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,cellDataChangedDelegate {

    @IBOutlet weak var mainTableView: UITableView!
    var dataSource = [DataModel]()
    var penmentData = [DataModelStruct]()
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.append(DataModel(sectionTitle: "First", subcellData: [SubCellDataModel(id: 1, data: "Prashant"),SubCellDataModel(id: 2, data: "Gajanan"),SubCellDataModel(id: 3, data: "Kaware")], isExpanded: true, sectionId: 1))
        dataSource.append(DataModel(sectionTitle: "First", subcellData: [SubCellDataModel(id: 4, data: "shubham"),SubCellDataModel(id: 5, data: "Gajanan"),SubCellDataModel(id: 6, data: "Girade")], isExpanded: true, sectionId: 2))
        dataSource.append(DataModel(sectionTitle: "First", subcellData: [SubCellDataModel(id: 7, data: "Jagat"),SubCellDataModel(id: 8, data: "Shirish"),SubCellDataModel(id: 9, data: "Deshmukh")], isExpanded: true, sectionId: 3))
        dataSource.append(DataModel(sectionTitle: "First", subcellData: [SubCellDataModel(id: 10, data: "X"),SubCellDataModel(id: 11, data: "Y"),SubCellDataModel(id: 12, data: "Z")], isExpanded: true, sectionId: 4))
        
        for i in dataSource{
            penmentData.append(DataModelStruct(sectionTitle: i.sectionTitle, subcellData: i.subcellData, isExpanded: i.isExpanded, sectionId: i.sectionId))
        }
        let nib = UINib(nibName: "MainTableViewCell", bundle: nil)
        mainTableView.register(nib, forCellReuseIdentifier: "MainTableViewCell")
        mainTableView.delegate = self
        mainTableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: Table view delegate and data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell") as! MainTableViewCell
        cell.dataSource = dataSource
        cell.penmentData = penmentData
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var minCount = 0
        let x = dataSource.count
        for c in dataSource{
            minCount = minCount + c.subcellData.count
        }
        print("cell height \(CGFloat(50 * (x + minCount)))")
        return CGFloat(50 * (x + minCount))
    }
    
    //MARK: custom delegate
    
    func refreshTable() {
        mainTableView.reloadData()
    }
    

}
