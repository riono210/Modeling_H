//
//  ViewController.swift
//  InputFunction
//
//  Created by 山下　耀崇 on 2017/12/02.
//  Copyright © 2017年 山下　耀崇. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate{


    @IBOutlet weak var Date: UITextField!
    @IBOutlet weak var InputMoney: UITextField!
    @IBOutlet weak var Table01: UITableView!
    @IBOutlet weak var TableViewCell:UITableViewCell!
    
    @IBOutlet weak var Test01: UILabel!
  
    var dataSource: DataSourceItem?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func setup() {
        
        dataSource = DataSourceItem(items: [Item(title: "x"),Item(title: "y"),Item(title: "z")],
                                    cellIdentifier: "ItemCell") {
                                        (cell, item) in
                                        if let cell = cell as? TableViewCell, let item = item as? Item {
                                            cell.item = item
                                        }
        }
        Table01.dataSource = dataSource
    
    
}


}

