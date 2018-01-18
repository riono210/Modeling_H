import UIKit
import Foundation

class EarningViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var sumLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var moneyTag = [String]()
    var moneyData = [String]()
    var moneyCategory = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tableviewの大きさを変更するのに必要
        tableView.dataSource = self
        tableView.delegate = self
        daysLabel.text = dates()
        //        sumLabel.text = "合計 \(sumPrice()) 円"
        
        tableView.sectionHeaderHeight = 500
        
                let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
                if appDelegate.Tagtext != nil && appDelegate.Datatext != nil && appDelegate.Categorytext != nil{
                    if moneyTag.isEmpty && moneyData.isEmpty && moneyCategory.isEmpty{
                        moneyTag.append(appDelegate.Tagtext!)
                        moneyData.append(appDelegate.Datatext!)
                        moneyCategory.append(appDelegate.Categorytext!)
                    }else{
                        if moneyTag[moneyTag.count-1] == appDelegate.Tagtext && moneyData[moneyData.count-1] == appDelegate.Datatext && moneyCategory[moneyCategory.count-1] == appDelegate.Categorytext{
                            moneyTag.append(appDelegate.Tagtext!)
                            moneyData.append(appDelegate.Datatext!)
                            moneyCategory.append(appDelegate.Categorytext!)
        
                            moneyTag.removeLast()
                            moneyData.removeLast()
                            moneyCategory.removeLast()
                        }else{
                            moneyTag.append(appDelegate.Tagtext!)
                            moneyData.append(appDelegate.Datatext!)
                            moneyCategory.append(appDelegate.Categorytext!)
                        }
                    }
                }
        
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
    
    // 合計の計算
    func sumPrice() -> String{
        var sum: Int = 0
        if moneyData.isEmpty{
            sum = 0
        }else{
            for i in 0...moneyData.count-1{
                sum += Int(moneyData[i])!
            }
        }
        return String(sum)
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
        return  moneyTag.count
    }
    
    // cellに表示する中身
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "moneyCell")
        // 背景の色
        cell.backgroundColor = UIColor.yellow
        cell.textLabel?.font = UIFont.systemFont(ofSize: 30)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 30)
        
        let price: String = String(moneyData[indexPath.row])
        // 表示するテキスト　改変する可能性あり
        cell.textLabel!.text = (moneyCategory[indexPath.row])
        cell.detailTextLabel?.text = "\(moneyTag[indexPath.row])            \(price)円"
        return cell
    }
    
    // Cellの高さを決める
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
    
    // cellを選択した時の動作
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        loadView()
//        viewDidLoad()
//    }
}


