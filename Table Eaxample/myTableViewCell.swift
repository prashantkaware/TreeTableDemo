//
//  myTableViewCell.swift
//  Table Eaxample
//
//  Created by Prashant on 20/03/20.
//  Copyright © 2020 Prashant. All rights reserved.
//

import UIKit
protocol myTableViewCellDelegate: AnyObject {
    func didSelectSubcell(index: myTableViewCell)
}

class myTableViewCell: UITableViewCell {

    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var labelName: UILabel!
    weak var delegate: myTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func onClickButtonSelect(_ sender: UIButton) {
        delegate?.didSelectSubcell(index: self)
    }
    
}
