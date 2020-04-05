//
//  HeaderView.swift
//  Table Eaxample
//
//  Created by Prashant on 29/03/20.
//  Copyright © 2020 Prashant. All rights reserved.
//

import UIKit
protocol HeaderViewDelegate: AnyObject {
    func didClickDropDownHeader(index:Int)
    func didClickCheckHeader(index:Int)
    func didTapView(index:Int)
}
class HeaderView: UITableViewHeaderFooterView {


    @IBOutlet weak var contenersView: UIView!
    @IBOutlet weak var btnCheckHeader: UIButton!
    @IBOutlet weak var labelSectionName: UILabel!
    
    @IBOutlet weak var btnDropDown: UIButton!
    

    weak var delegate: HeaderViewDelegate?
    
    override func awakeFromNib (){
        
        contenersView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderAction)))
    }
    @objc func selectHeaderAction(gestureRecognizer: UITapGestureRecognizer) {
        delegate?.didTapView(index: contenersView.tag)
    }
    @IBAction func onClickDropDownHeader(_ sender: UIButton) {
        delegate?.didClickDropDownHeader(index: sender.tag)
    }
    //    @IBAction func onClickDropDownHeader(_ sender: UIButton) {
//        delegate?.didClickDropDownHeader(index: sender.tag)
//    }
    @IBAction func OnClickCheckHeader(_ sender: UIButton) {
        delegate?.didClickCheckHeader(index: sender.tag)
    }
    //    @IBAction func OnClickCheckHeader(_ sender: UIButton) {
//        delegate?.didClickCheckHeader(index: sender.tag)
//    }
}
