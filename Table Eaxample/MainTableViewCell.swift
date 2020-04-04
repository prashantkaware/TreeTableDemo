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
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        
        let titleLabel = UILabel()
        titleLabel.frame = CGRect(x: 11, y: 8, width:170, height: 18)
        titleLabel.text = dataSource[section].sectionTitle
        titleLabel.font = titleLabel.font.withSize(16)
        
        let button = UIButton(type: .system)
        button.setTitle("See All", for: .normal)
        //button.setTitleColor(UIColor.customBlueColor, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.frame = CGRect(x: 303, y: 14, width: 62, height: 12)
        button.addTarget(self, action: #selector(showDetail(_:)), for: .touchUpInside)
        
        button.tag = section
        
        view.addSubview(titleLabel)
        view.addSubview(button)
        
        return view
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
