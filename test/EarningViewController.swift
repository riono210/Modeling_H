//
//  EarningViewController.swift
//  
//
//  Created by 内原　朝也 on 2018/02/01.
//

import UIKit
import Charts
import RealmSwift

class EarningViewController: UIViewController {

    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var expenceAmount: UILabel!
    @IBOutlet weak var incomeAmount: UILabel!
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var pieChartView: PieChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateChartWithData()
        
        todayLabel.text = dates()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dates () -> String{
        let date = Date()
        let format: DateFormatter = DateFormatter()
        format.dateFormat = "yyyy年MM月dd日"
        let sDate = format.string(from: date)
        return sDate
    }
    
    func updateChartWithData(){
        var dataEntries = [PieChartDataEntry]()
        
        let expenceData = getdataFromexpenceData()
        
        for i in 0..<expenceData.count {
            let dataEntry = PieChartDataEntry(value: Double(expenceData[i].data), label: expenceData[i].label)
            dataEntries.append(dataEntry)
        }
        let dataSet = PieChartDataSet(values: dataEntries, label: "ラベル")
        //グラフの色　パターン1
        //dataSet.colors = ChartColorTemplates.colorful()
        //グラフの色　パターン2
        dataSet.colors = ChartColorTemplates.vordiplom()
        pieChartView.chartDescription?.enabled = false  // グラフの説明を非表示
        pieChartView.legend.enabled = false  // グラフの注釈を非表示
        
        let data = PieChartData(dataSet: dataSet)
        
        pieChartView.data = data
        
        var num_e: Int = 0
        for i in 0..<expenceData.count {
            num_e += expenceData[i].data
        }
        expenceAmount.text = String(num_e)
        expenceAmount.textColor = UIColor.red
        
        var num_i: Int = 0
        let incomeData = getdataFromincomeData()
        for i in 0..<incomeData.count {
            num_i += incomeData[i].data
        }
        incomeAmount.text = String(num_i)
        incomeAmount.textColor = UIColor.blue
        
        totalAmount.text = String(num_i - num_e)
        if (num_i - num_e) < 0 {
            totalAmount.textColor = UIColor.red
        }else {
            totalAmount.textColor = UIColor.blue
        }
        
        
    }
    
    func getdataFromexpenceData()-> Results<expenceData>{
        do {
            let realm = try Realm()
            print(Realm.Configuration.defaultConfiguration.fileURL!)
            return realm.objects(expenceData.self)
            
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    func getdataFromincomeData()-> Results<incomeData>{
        do {
            let realm = try Realm()
            print(Realm.Configuration.defaultConfiguration.fileURL!)
            return realm.objects(incomeData.self)
            
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }


}
