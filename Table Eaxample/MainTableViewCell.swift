//
//  MainTableViewCell.swift
//  Table Eaxample
//
//  Created by Prashant on 04/04/20.
//  Copyright © 2020 Prashant. All rights reserved.
//

import UIKit
protocol cellDataChangedDelegate: AnyObject {
    func refreshTable()
}
class MainTableViewCell: UITableViewCell,UITableViewDelegate,UITableViewDataSource,myTableViewCellDelegate,HeaderViewDelegate  {

    @IBOutlet weak var tableSubData: UITableView!
    var dataSource = [DataModel]()
    var penmentData = [DataModelStruct]()
    var delegate: cellDataChangedDelegate?
    var selectedSectionIds = [Int]()
    var subCellSectionIds = [Int]()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tableSubData.delegate = self
        tableSubData.dataSource = self
        let nib = UINib(nibName: "myTableViewCell", bundle: nil)
        tableSubData.register(nib, forCellReuseIdentifier: "myTableViewCell")
        let headerNib = UINib(nibName: "HeaderView", bundle: nil)
        tableSubData.register(headerNib, forHeaderFooterViewReuseIdentifier: "HeaderView")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as! HeaderView
        headerView.clipsToBounds = true
        headerView.delegate = self
        headerView.btnCheckHeader.tag = section
        headerView.btnDropDown.tag = section
        headerView.labelSectionName.text = dataSource[section].sectionTitle
        if selectedSectionIds.contains(dataSource[section].sectionId){
            headerView.btnDropDown.setImage(#imageLiteral(resourceName: "downArrow"), for: .normal)
            headerView.btnCheckHeader.setImage(#imageLiteral(resourceName: "selectedCircle"), for: .normal)
        }else{
            headerView.btnDropDown.setImage(#imageLiteral(resourceName: "upArrow"), for: .normal)
            headerView.btnCheckHeader.setImage(#imageLiteral(resourceName: "unselectedCircle"), for: .normal)
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].subcellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myTableViewCell") as! myTableViewCell
        let cellData = dataSource[indexPath.section].subcellData[indexPath.row]
        
//        if dataSource[indexPath.section].subcellData.count == 2{
//        if selectedSectionIds.contains(dataSource[indexPath.section].sectionId){
//            cell.btnSelect.setImage(#imageLiteral(resourceName: "selectedCircle"), for: .normal)
//        }else{
//            cell.btnSelect.setImage(#imageLiteral(resourceName: "unselectedCircle"), for: .normal)
//        }
//        }else{
            if subCellSectionIds.contains(dataSource[indexPath.section].subcellData[indexPath.row].id){
                cell.btnSelect.setImage(#imageLiteral(resourceName: "selectedCircle"), for: .normal)
            }else{
                cell.btnSelect.setImage(#imageLiteral(resourceName: "unselectedCircle"), for: .normal)
            }
        //}
        cell.delegate = self
        cell.labelName.text = cellData.data
        return cell
    }

    //MARK: Custom delegate
    //MARK: Header custom delegates
   
    func didClickDropDownHeader(index: Int) {
        print("didClickDropDownHeader \(index)")
        delegate?.refreshTable()
        HandleExpandCollaps(index: index)
    }
    
    func didClickCheckHeader(index: Int) {
        print("didClickCheckHeader \(index)")
        if selectedSectionIds.contains(dataSource[index].sectionId){
            selectedSectionIds = selectedSectionIds.filter({$0 != dataSource[index].sectionId})
        }else{
            selectedSectionIds.append(dataSource[index].sectionId)
        }
        if dataSource[index].isExpanded == false{
            delegate?.refreshTable()
            print("didClickDropDownHeader \(index)")
            HandleExpandCollaps(index: index)
        }
        tableSubData.reloadSections([index], with: .none)
        print(selectedSectionIds)
    }
    
    func didTapView(index: Int) {
        print("didTapView \(index)")
        HandleExpandCollaps(index: index)
    }
    func HandleExpandCollaps(index:Int){
        if dataSource[index].isExpanded{
            dataSource[index].isExpanded = false
            dataSource[index].subcellData = []
            tableSubData.reloadSections([index], with: .none)
        }else{
            dataSource[index].isExpanded = true
            dataSource[index].subcellData = penmentData[index].subcellData
            tableSubData.reloadSections([index], with: .none)
        }
    }
    
    //MARK:- Table custom delegates
    
    func didSelectSubcell(index: myTableViewCell) {
        guard let indexPath = tableSubData.indexPath(for: index) else {return}
        if subCellSectionIds.contains(dataSource[indexPath.section].subcellData[indexPath.row].id){
            subCellSectionIds = subCellSectionIds.filter({$0 != dataSource[indexPath.section].subcellData[indexPath.row].id})
        }else{
            subCellSectionIds.append(dataSource[indexPath.section].subcellData[indexPath.row].id)
        }
        tableSubData.reloadRows(at: [indexPath], with: .none)
        print(subCellSectionIds)
    }
    
}
