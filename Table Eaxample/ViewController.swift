//
//  ViewController.swift
//  Table Eaxample
//
//  Created by Prashant on 20/03/20.
//  Copyright © 2020 Prashant. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,myTableViewCellDelegate,HeaderViewDelegate {

    @IBOutlet weak var myTable: UITableView!
    var dataSource = [DataModel]()
    var penmentData = [DataModelStruct]()
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.append(DataModel(sectionTitle: "First", subcellData: ["Prashant","Gajanan","Kaware"], isExpanded: false))
        dataSource.append(DataModel(sectionTitle: "Second", subcellData: ["shubham","Gajanan","Girade"], isExpanded: false))
        dataSource.append(DataModel(sectionTitle: "Third", subcellData: ["Jagat","Shirish","Deshmukh"], isExpanded: false))
        dataSource.append(DataModel(sectionTitle: "Forth", subcellData: ["X","Y","Z"], isExpanded: false))
        for i in dataSource{
            penmentData.append(DataModelStruct(sectionTitle: i.sectionTitle, subcellData: i.subcellData, isExpanded: i.isExpanded))
        }
        
        myTable.delegate = self
        myTable.dataSource = self
        let nib = UINib(nibName: "myTableViewCell", bundle: nil)
        myTable.register(nib, forCellReuseIdentifier: "myTableViewCell")
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as! HeaderView
        headerView.delegate = self
        headerView.btnCheckHeader.tag = section
        headerView.btnDropDown.tag = section
        headerView.contenersView.tag = section
        headerView.contenersView.tag = section
        return headerView
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].subcellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myTableViewCell") as! myTableViewCell
        let cellData = dataSource[indexPath.section].subcellData[indexPath.row]
        cell.delegate = self
        cell.labelName.text = cellData
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: Custom delegate
    //MARK: Header custom delegates
    
    func didClickDropDownHeader(index: Int) {
        print("didClickDropDownHeader \(index)")
    }
    
    func didClickCheckHeader(index: Int) {
        print("didClickCheckHeader \(index)")
    }
    
    func didTapView(index: Int) {
        print("didTapView \(index)")
        HandleExpandCollaps(index: index)
    }
    func HandleExpandCollaps(index:Int){
        if dataSource[index].isExpanded{
            dataSource[index].isExpanded = false
            dataSource[index].subcellData = []
            myTable.reloadSections([index], with: .none)
        }else{
            dataSource[index].isExpanded = true
            dataSource[index].subcellData = penmentData[index].subcellData
            myTable.reloadSections([index], with: .none)
    }
    }
    
    //MARK:- Table custom delegates
    
    func didSelectSubcell(index: myTableViewCell) {
        guard let indexPath = myTable.indexPath(for: index) else {return}
        print(indexPath)
    }


}

