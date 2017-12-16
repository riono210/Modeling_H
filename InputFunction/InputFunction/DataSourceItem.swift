//
//  DataSource_Item.swift
//  InputFunction
//
//  Created by 山下　耀崇 on 2017/12/14.
//  Copyright © 2017年 山下　耀崇. All rights reserved.
//

import UIKit
//UITableViewDataSourceの拡張クラス

typealias TableViewCellConfigureBlock = (_ cell: UITableViewCell, _ item: NSObject) -> Void
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

extension DataSourceItem: UITableViewDataSource {
    //MARK: - UITableViewDataSource
    
    //各セルを生成して返却
    func tableView(_ tableview: UITableView, numberOfRowsInSection section: Int) ->Int{
        //配列「items」の要素数
        return items.count
    }
    //indexPathの設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        if let cell  = cell as? TableViewCell{
            //self.cellIdentifier(items: items[indexPath.section][indexPath.row])
        }
        
        return cell
    }
    
    
        //テーブルの行ごとのセルを返す
  
    //MARK: - Private
    private func itemAtIndexPath(indexPath: NSIndexPath) -> NSObject{
        return items[indexPath.row]
    }
}


