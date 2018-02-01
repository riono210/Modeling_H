//
//  Expence.swift
//  test
//
//  Created by 内原　朝也 on 2018/01/29.
//  Copyright © 2018年 松下亮太. All rights reserved.
//

import UIKit
import RealmSwift

//支出のテーブルを表示するためのクラス
class Expence: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    weak var parent: InputViewController!
    
    var myItem_2: [expenceData] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.delegate = self
        self.dataSource = self
        self.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let realm = try! Realm()
        let myObj = realm.objects(expenceData.self)
        myItem_2 = []
        myObj.forEach{item in
            myItem_2.append(item)
        }
    }
    
    
    
    // これがないとヘッダーが表示されない
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title =  " "
        return title
    }
    
    //この関数内でヘッダーの設定を行う
    internal func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel(frame: CGRect(x:0, y:0, width: tableView.bounds.width, height: 50))
        label.text = " カテゴリ                                                  タイトル          金額"
        label.font = UIFont.italicSystemFont(ofSize: 30)
        return label
    }
    
    // sectionの数を決める
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myItem_2.count
    }
    
    // cellに表示する中身
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "moneyCell")
        // 背景の色
        cell.backgroundColor = UIColor.yellow
        cell.textLabel?.font = UIFont.systemFont(ofSize: 30)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 30)
        
        let price: String = String(myItem_2[indexPath.row].data)
        cell.textLabel!.text = (myItem_2[indexPath.row].Category)
        cell.detailTextLabel?.text = "\(myItem_2[indexPath.row].label)            \(price)円"
        
        awakeFromNib()
        
        return cell
    }
    
    // Cellの高さを決める
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
    
    // cellを選択した時の動作
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
