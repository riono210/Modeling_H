//
//  ViewController.swift
//  incomeAndExpenditure
//
//  Created by 安田亮 on 2017/12/09.
//  Copyright © 2017年 riono210. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var days: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // 仮置きデータ
    let moneyTag = ["水道代", "外食", "本題"]
    let moneyDeta = ["800", "3000", "2000"]
    let moneyCategory = ["光熱費", "生活費", "雑費"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // tableviewの大きさを変更するのに必要
        tableView.dataSource = self
        tableView.delegate = self
        days.text = dates()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // 日付の取得
    func dates () -> String{
        let date = Date()
        let format: DateFormatter = DateFormatter()
        format.dateFormat = "yyyy年MM月dd日"
        
        let sDate = format.string(from: date)
        return sDate
    }

    // sectionの数を決める
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moneyTag.count
    }
    
    // cellに表示する中身
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "moneyCell", for: indexPath)
        let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "moneyCell")
        // 背景の色
        cell.backgroundColor = UIColor.yellow
        
        // 表示するテキスト　改変する可能性あり
        cell.textLabel!.text = (moneyTag[indexPath.row])
        cell.detailTextLabel?.text = "\(moneyCategory[indexPath.row])           \(moneyDeta[indexPath.row])円"
        return cell
    }
    
    // Cellの高さを決める
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
    
    // cellを洗濯した時の動作
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

