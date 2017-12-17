//
//  DataSource_Item.swift
//  InputFunction
//
//  Created by 山下　耀崇 on 2017/12/14.
//  Copyright © 2017年 山下　耀崇. All rights reserved.
//

import UIKit
//UITableViewDataSourceの拡張クラス

typealias TableViewCellConfigureBlock = ( _ cell: UITableViewCell,  _ item: NSObject) -> Void
class DataSourceItem: NSObject {
    var items = [NSObject]()
    var cellIdentifier = ""
    var configureCellBlock: TableViewCellConfigureBlock?
    
    init(items: [Item], cellIdentifier: String, configureCellBlock:@escaping TableViewCellConfigureBlock) {
        self.items = items
        self.cellIdentifier = cellIdentifier
        self.configureCellBlock = configureCellBlock
    }

}
 //MARK: - UITableViewDataSource
extension DataSourceItem: UITableViewDataSource {
    
    //indexPathの設定
    //各セルを生成して返却
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cellIdentifier",
            for: indexPath
        )
        if let configureCellBlock = self.configureCellBlock {
            configureCellBlock (cell, self.itemAtIndexPath(indexPath: indexPath as NSIndexPath))
        }
            return cell
    }
  
    
    
        //テーブルの行ごとのセルを返す
  
   // MARK: - Private
    private func itemAtIndexPath(indexPath: NSIndexPath) -> NSObject{
        return items[indexPath.row]
    }
}


