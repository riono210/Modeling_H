//
//  ViewController.swift
//  InputFunction
//
//  Created by 山下　耀崇 on 2017/12/02.
//  Copyright © 2017年 山下　耀崇. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var Table01: UITableView!
//    private var datasource: DataSourceItem = DataSourceItem(items: [])
    var dataSource: DataSourceItem?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }

    private func setup() {
        
        dataSource = DataSourceItem(items: [Item(title: "¥"),Item(title: "¥"),Item(title: "¥")],
                                    cellIdentifier: "ItemCell") {
                                        (cell, item) in
                                        if let cell = cell as? TableViewCell, let item = item as? Item {
                                            cell.item = item
                                     }
        }
        Table01.dataSource = dataSource
        Table01.delegate = self
    
}
}
extension ViewController : UITableViewDelegate{
    
}


