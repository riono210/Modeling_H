import UIKit
import RealmSwift

class InputViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate, UITabBarDelegate, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    @IBOutlet weak var categoryField: UITextField!
    @IBOutlet weak var labelField: UITextField!
    @IBOutlet weak var amountField: UITextField!
    
    @IBOutlet weak var changeLabel: UILabel!
    
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    
    let pickerView = UIPickerView()
    var pickOption = ["バイト・給料","その他"]
    
    var segCount = 0
    var c = Int()
    var incomeItem: Results<testincome>!
    var expenceItem: Results<testexpence>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //日付の表示
        //AppDelegateのインスタンスを取得
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if appDelegate.year == nil {
            yearLabel.text = dates(c: "year")
            monthLabel.text = dates(c: "month")
            dayLabel.text = dates(c: "day")
        }else {
            //AppDelegateで設定した値をラベルに設定
            yearLabel.text = appDelegate.year
            let month = String(format: "%02d", Int(appDelegate.month!)!)
            monthLabel.text = month
            let day = String(format: "%02d", Int(appDelegate.day!)!)
            dayLabel.text = day
        }
        
        //テーブルに表示するためのデータ挿入
        do {
            // スキーマバージョンを上げる。デフォルトのスキーマバージョンは0
            let config = Realm.Configuration(schemaVersion: 2)
            Realm.Configuration.defaultConfiguration = config
            
            let realm = try Realm()
            print(Realm.Configuration.defaultConfiguration.fileURL!)
            incomeItem = realm.objects(testincome.self).sorted(byKeyPath: "num", ascending: false).filter("year == %@ AND month == %@ AND day ==  %@",Int(yearLabel.text!)! ,Int(monthLabel.text!)!, Int(dayLabel.text!)!)
            tableView.reloadData()
            if incomeItem.isEmpty {
                c = 0
            }else {
                c = incomeItem[0].num
            }
        }catch {
        }
        
        do {
            // スキーマバージョンを上げる。デフォルトのスキーマバージョンは0
            let config = Realm.Configuration(schemaVersion: 2)
            Realm.Configuration.defaultConfiguration = config
            
           let realm = try Realm()
            expenceItem = realm.objects(testexpence.self).sorted(byKeyPath: "num", ascending: false).filter("year == %@ AND month == %@ AND day ==  %@",Int(yearLabel.text!)! ,Int(monthLabel.text!)!, Int(dayLabel.text!)!)
            tableView.reloadData()
            if expenceItem.isEmpty {
                c = 0
            }else {
                c = expenceItem[0].num
            }
        }catch{
        }
        
        //金額項目に数字入力のみ行える
        NotificationCenter.default.addObserver(self,selector:#selector(textFieldDidChange),name: NSNotification.Name.UITextFieldTextDidChange,object: amountField)

        //以下は全て入力するUITextFieldの細かい設定
        pickerView.delegate = self
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(InputViewController.donePressed))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(InputViewController.canclePressed))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        amountField.delegate = self
        amountField.inputAccessoryView = toolBar
        
        labelField.delegate = self
        labelField.inputAccessoryView = toolBar
        
        categoryField.delegate = self
        categoryField.inputView = pickerView
        categoryField.inputAccessoryView = toolBar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //テーブルの再表示(同じ日付のみをテーブルに表示したいので検索をかけている)
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
        
        //AppDelegateのインスタンスを取得
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if appDelegate.year == nil {
            yearLabel.text = dates(c: "year")
            monthLabel.text = dates(c: "month")
            dayLabel.text = dates(c: "day")
        }else {
            //AppDelegateで設定した値をラベルに設定
            yearLabel.text = appDelegate.year
            let month = String(format: "%02d", Int(appDelegate.month!)!)
            monthLabel.text = month
            let day = String(format: "%02d", Int(appDelegate.day!)!)
            dayLabel.text = day
        }
        
        do {
            // スキーマバージョンを上げる。デフォルトのスキーマバージョンは0
            let config = Realm.Configuration(schemaVersion: 1)
            Realm.Configuration.defaultConfiguration = config
            
            let realm = try Realm()
            print(Realm.Configuration.defaultConfiguration.fileURL!)
            incomeItem = realm.objects(testincome.self).sorted(byKeyPath: "num", ascending: false).filter("year == %@ AND month == %@ AND day ==  %@",Int(yearLabel.text!)! ,Int(monthLabel.text!)!, Int(dayLabel.text!)!)
            tableView.reloadData()
            if incomeItem.isEmpty {
                c = 0
            }else {
                c = incomeItem[0].num
            }
        }catch {
        }
        
        do {
            // スキーマバージョンを上げる。デフォルトのスキーマバージョンは0
            let config = Realm.Configuration(schemaVersion: 2)
            Realm.Configuration.defaultConfiguration = config
            
            let realm = try Realm()
            expenceItem = realm.objects(testexpence.self).sorted(byKeyPath: "num", ascending: false).filter("year == %@ AND month == %@ AND day ==  %@",Int(yearLabel.text!)! ,Int(monthLabel.text!)!, Int(dayLabel.text!)!)
            tableView.reloadData()
            if expenceItem.isEmpty {
                c = 0
            }else {
                c = expenceItem[0].num
            }
        }catch{
        }
        tableView.reloadData()
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
    
    //以下UITextFieldに関する設定
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickOption.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickOption[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        return categoryField.text = pickOption[row]
    }
    
    @objc func donePressed(sender: UIBarButtonItem) {
        self.view.endEditing(true)
    }
    
    @objc func canclePressed(sender: UIBarButtonItem) {
        categoryField.text = ""
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ Text: UITextField) -> Bool {
        amountField.resignFirstResponder()
        labelField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        amountField.resignFirstResponder()
        labelField.resignFirstResponder()
        self.view.endEditing(true)
    }
    
    //以下は，テーブルの表示設定
    // これがないとヘッダーが表示されない
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title =  " "
        return title
    }
    
    //この関数内でヘッダーの設定を行う
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel(frame: CGRect(x:0, y:0, width: tableView.bounds.width, height: 50))
        label.text = " カテゴリ                                                  タイトル          金額"
        label.font = UIFont.italicSystemFont(ofSize: 30)
        return label
    }
    
    // sectionの数を決める
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var i = Int()
        if segCount == 0 {
            i = incomeItem.count
        }else {
            i = expenceItem.count
        }
        return i
    }
    
    // cellに表示する中身
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "moneyCell")
        // 背景の色
//        cell.backgroundColor = UIColor.yellow
        cell.textLabel?.font = UIFont.systemFont(ofSize: 30)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 30)
        
        if segCount == 0 {
            cell.backgroundColor = UIColor(red: 183/255, green:219/255, blue:255/255, alpha: 1.0)
            let price: String = String(incomeItem[indexPath.row].data)
            cell.textLabel!.text = (incomeItem[indexPath.row].Category)
            cell.detailTextLabel?.text = "\(incomeItem[indexPath.row].label)            \(price)円"
        }else {
            cell.backgroundColor = UIColor(red: 255/255, green: 183/255, blue: 183/255, alpha: 1.0)
            let price: String = String(expenceItem[indexPath.row].data)
            cell.textLabel!.text = (expenceItem[indexPath.row].Category)
            cell.detailTextLabel?.text = "\(expenceItem[indexPath.row].label)            \(price)円"
        }
        
        return cell
    }
    
    // Cellの高さを決める
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
    
    // cellを選択した時の動作
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    // TableViewのCellの削除を行った際に、Realmに保存したデータを削除する
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == UITableViewCellEditingStyle.delete) {
            if segCount == 0{
                do{
                    // スキーマバージョンを上げる。デフォルトのスキーマバージョンは0
                    let config = Realm.Configuration(schemaVersion: 1)
                    Realm.Configuration.defaultConfiguration = config
                    
                    let realm = try Realm()
                    try realm.write {
                        realm.delete(self.incomeItem[indexPath.row])
                    }
                    tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.fade)
                }catch{
                }
                if incomeItem.count != 0 {
                    c = incomeItem[0].num
                    tableView.reloadData()
                }else {
                    c = 0
                    tableView.reloadData()
                }
            }else {
                do{
                    // スキーマバージョンを上げる。デフォルトのスキーマバージョンは0
                    let config = Realm.Configuration(schemaVersion: 2)
                    Realm.Configuration.defaultConfiguration = config
                    let realm = try Realm()
                    try realm.write {
                        realm.delete(self.expenceItem[indexPath.row])
                    }
                    tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.fade)
                }catch{
                }
                if incomeItem.count != 0 {
                    c = expenceItem[0].num
                    tableView.reloadData()
                }else {
                    c = 0
                    tableView.reloadData()
                }
            }
        }
    }

    
    
    
    @IBAction func changeSegment(_ sender: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0 {
            changeLabel.text = "収入"
            pickOption = ["バイト・給料","その他"]
            categoryField.text = ""
            segCount = 0
            tableView.reloadData()
        } else {
            changeLabel.text = "支出"
            pickOption = ["食費","日用品","交通費","本・雑誌","携帯電話・インターネット","医療費・医薬品","交際費","家賃","衣類","水道・電気・ガス","その他"]
            categoryField.text = ""
            segCount = 1
            tableView.reloadData()
        }
    }
    
    @IBAction func addDataBtn(_ sender: UIButton) {
        if amountField.text != "" && labelField.text != "" && categoryField.text != "" {
            if segCount == 0{
                let incomedata = testincome()
                c += 1
                
                incomedata.year = Int(yearLabel.text!)!
                incomedata.month = Int(monthLabel.text!)!
                incomedata.day = Int(dayLabel.text!)!
                incomedata.data = Int(amountField.text!)!
                incomedata.label = labelField.text!
                incomedata.Category = categoryField.text!
                incomedata.num = c
                
                //上記で代入したデータを永続化
                do {
                    let realm = try Realm()
                    try realm.write({ () -> Void in
                        realm.add(incomedata)
                    })
                }catch {
                }
            }else {
                let expencedata = testexpence()
                c += 1
                expencedata.year = Int(yearLabel.text!)!
                expencedata.month = Int(monthLabel.text!)!
                expencedata.day = Int(dayLabel.text!)!
                expencedata.data = Int(amountField.text!)!
                expencedata.label = labelField.text!
                expencedata.Category = categoryField.text!
                expencedata.num = c
                
                //上記で代入したデータを永続化
                do {
                    let realm = try Realm()
                    try realm.write({ () -> Void in
                        realm.add(expencedata)
                    })
                }catch {
                }
            }
        }
        amountField.text = ""
        labelField.text = ""
        categoryField.text = ""
        tableView.reloadData()
    }
    
    //金額項目に数字入力のみにする
    @objc func textFieldDidChange(notification: NSNotification) {
        let textField = notification.object as! UITextField
        guard let text = textField.text else { return }
        guard Int(text) != nil else { textField.text = ""; return }
    }

}
