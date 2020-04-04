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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tableSubData.delegate = self
        tableSubData.dataSource = self
        let nib = UINib(nibName: "myTableViewCell", bundle: nil)
        tableSubData.register(nib, forCellReuseIdentifier: "myTableViewCell")
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
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
        view.backgroundColor = UIColor.lightGray
        
        
        let buttonDropDown = UIButton(type: .system)
        buttonDropDown.frame = CGRect(x: 15, y: 8, width: 20, height: 20)
        buttonDropDown.setImage(#imageLiteral(resourceName: "upArrow"), for: .normal)
        buttonDropDown.addTarget(self, action: #selector(showDetail(_:)), for: .touchUpInside)
        buttonDropDown.tag = section
       
        
        let buttonSelectSection = UIButton(type: .system)
        buttonSelectSection.frame = CGRect(x: 45, y: 8, width: 20, height: 20)
        buttonSelectSection.addTarget(self, action: #selector(HandleHeadeSelection(_:)), for: .touchUpInside)
        buttonSelectSection.tag = section
        buttonSelectSection.tag = section
        
        if selectedSectionIds.contains(dataSource[section].sectionId){
            buttonDropDown.setImage(#imageLiteral(resourceName: "downArrow"), for: .normal)
            buttonSelectSection.setImage(#imageLiteral(resourceName: "selectedCircle"), for: .normal)
        }else{
            buttonDropDown.setImage(#imageLiteral(resourceName: "upArrow"), for: .normal)
            buttonSelectSection.setImage(#imageLiteral(resourceName: "unselectedCircle"), for: .normal)
        }
        let titleLabel = UILabel()
        titleLabel.frame = CGRect(x: 75, y: 8, width: tableView.frame.size.width - 85, height: 18)
        titleLabel.text = dataSource[section].sectionTitle
        titleLabel.font = titleLabel.font.withSize(16)
        
       
        view.addSubview(buttonDropDown)
        view.addSubview(buttonSelectSection)
        view.addSubview(titleLabel)
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].subcellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myTableViewCell") as! myTableViewCell
        let cellData = dataSource[indexPath.section].subcellData[indexPath.row]
        if selectedSectionIds.contains(dataSource[indexPath.section].sectionId){
            cell.btnSelect.setImage(#imageLiteral(resourceName: "selectedCircle"), for: .normal)
        }else{
            cell.btnSelect.setImage(#imageLiteral(resourceName: "unselectedCircle"), for: .normal)
        }
        cell.delegate = self
        cell.labelName.text = cellData
        return cell
    }
    @objc func HandleHeadeSelection(_ button:UIButton){
        if selectedSectionIds.contains(dataSource[button.tag].sectionId){
            selectedSectionIds = selectedSectionIds.filter({$0 != dataSource[button.tag].sectionId})
        }else{
            selectedSectionIds.append(dataSource[button.tag].sectionId)
        }
        if dataSource[button.tag].isExpanded == false{
            delegate?.refreshTable()
            print("didClickDropDownHeader \(button.tag)")
            HandleExpandCollaps(index: button.tag)
        }
        tableSubData.reloadSections([button.tag], with: .none)
        print(selectedSectionIds)
    }
    //MARK: Custom delegate
    //MARK: Header custom delegates
    @objc func showDetail(_ button:UIButton){
        delegate?.refreshTable()
        print("didClickDropDownHeader \(button.tag)")
        HandleExpandCollaps(index: button.tag)
    }
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
        print(indexPath)
    }
    
}
