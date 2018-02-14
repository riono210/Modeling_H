import UIKit
import Charts
import RealmSwift

class GraphViewController: UIViewController {
    

    @IBOutlet weak var linechartView: LineChartView!
    
    @IBOutlet weak var year: UILabel!
    
    var month: Int = 0
    
    var expenceData: Results<testexpence>!
    var incomeData: Results<testincome>!
    
    let monthArray = [1,2,3,4,5,6,7,8,9,10,11,12]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //日付の表示
        //AppDelegateのインスタンスを取得
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        if appDelegate.year == nil {
            year.text = dates(c: "year")
            month = Int(dates(c: "month"))!
        }else {
            //AppDelegateで設定した値をラベルに設定
            year.text = appDelegate.year
            let monthlabel = String(format: "%02d", Int(appDelegate.month!)!)
            month = Int(monthlabel)!
        }

        updateChartWithData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        updateChartWithData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateChartWithData()
        //日付の再表示
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        if appDelegate.year == nil {
            year.text = dates(c: "year")
            month = Int(dates(c: "month"))!
        }else {
            //AppDelegateで設定した値をラベルに設定
            year.text = appDelegate.year
            let monthlabel = String(format: "%02d", Int(appDelegate.month!)!)
            month = Int(monthlabel)!

        }
        updateChartWithData()
    }
    
    // 日付の取得
    func dates (c: String) -> String{
        let date = Date()
        let format: DateFormatter = DateFormatter()
        
        var sDate = format.string(from: date)
        
        if c == "year" {
            format.dateFormat = "yyyy"
            sDate = format.string(from: date)
            
        }else if c == "month" {
            format.dateFormat = "MM"
            sDate = format.string(from: date)
            
        }else if c == "day" {
            format.dateFormat = "dd"
            sDate = format.string(from: date)
            
        }
        return sDate
    }
    
    func updateChartWithData(){
        var dataEntries = [BarChartDataEntry]()
        
        var sum: Int
        var sum_i: Int
        var sum_e: Int
        
        for i in 0..<monthArray.count {
            do {
                // スキーマバージョンを上げる。デフォルトのスキーマバージョンは0
                let config = Realm.Configuration(schemaVersion: 2)
                Realm.Configuration.defaultConfiguration = config
                
                let realm = try Realm()
                print(Realm.Configuration.defaultConfiguration.fileURL!)
                incomeData = realm.objects(testincome.self).sorted(byKeyPath: "num", ascending: false).filter("year == %@ AND month == %@",Int(year.text!)! ,monthArray[i])
                
            } catch let error as NSError {
                fatalError(error.localizedDescription)
            }
            
            do {
                // スキーマバージョンを上げる。デフォルトのスキーマバージョンは0
                let config = Realm.Configuration(schemaVersion: 2)
                Realm.Configuration.defaultConfiguration = config
                
                let realm = try Realm()
                print(Realm.Configuration.defaultConfiguration.fileURL!)
                expenceData = realm.objects(testexpence.self).sorted(byKeyPath: "num", ascending: false).filter("year == %@ AND month == %@",Int(year.text!)! ,monthArray[i])
                
            } catch let error as NSError {
                fatalError(error.localizedDescription)
            }
            sum_e = expenceData.sum(ofProperty: "data")
            sum_i = incomeData.sum(ofProperty: "data")
            sum = sum_i - sum_e
            
            let dataEntry = BarChartDataEntry(x: Double(monthArray[i]), y: Double(sum))
            dataEntries.append(dataEntry)
            
            sum = 0
            sum_i = 0
            sum_e = 0

        }
        let dataSet = BarChartDataSet(values: dataEntries, label: "収支")
        let data = BarChartData(dataSet: dataSet)
        
        linechartView.data = data
    }
    
    @IBAction func nextBtn(_ sender: UIButton) {
        year.text = String(Int(year.text!)! + 1)
        updateChartWithData()
    }
    
    @IBAction func prevBtn(_ sender: UIButton) {
        year.text = String(Int(year.text!)! - 1)
        updateChartWithData()
    }
}
