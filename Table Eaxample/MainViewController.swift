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
        dataSource.append(DataModel(sectionTitle: "First", subcellData: ["Prashant","Gajanan","Kaware"], isExpanded: true))
        dataSource.append(DataModel(sectionTitle: "Second", subcellData: ["shubham","Gajanan","Girade"], isExpanded: true))
        dataSource.append(DataModel(sectionTitle: "Third", subcellData: ["Jagat","Shirish","Deshmukh"], isExpanded: true))
        dataSource.append(DataModel(sectionTitle: "Forth", subcellData: ["X","Y","Z"], isExpanded: true))
        for i in dataSource{
            penmentData.append(DataModelStruct(sectionTitle: i.sectionTitle, subcellData: i.subcellData, isExpanded: i.isExpanded))
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
