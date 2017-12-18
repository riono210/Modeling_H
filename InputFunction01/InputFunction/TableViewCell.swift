//
//  TableViewCell.swift
//  InputFunction
//
//  Created by 山下　耀崇 on 2017/12/14.
//  Copyright © 2017年 山下　耀崇. All rights reserved.
//

import UIKit
//UITableViewの拡張したクラス
class TableViewCell: UITableViewCell {

    @IBOutlet weak var Test01: UILabel!
    
    var item: Item? {
        didSet {
            
            if let item = item {
                self.Test01.text = item.title
            }
        }
    }
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
