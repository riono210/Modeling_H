import UIKit
import FSCalendar
import Foundation

class InputViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate, UITabBarDelegate, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var Money: UITextField!
    @IBOutlet weak var cost: UITextField!
    @IBOutlet weak var pickerTextField: UITextField!
    
    @IBOutlet weak var testLabel: UILabel!
    
    @IBOutlet weak var textYear: UILabel!
    @IBOutlet weak var textMonth: UILabel!
    @IBOutlet weak var textDay: UILabel!
    
    @IBOutlet weak var InputTableView: UITableView!
    
    let pickerView = UIPickerView()
    
    var pickOption = ["カテゴリ1", "カテゴリ2", "カテゴリ3", "カテゴリ4", "カテゴリ5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tableviewの大きさを変更するのに必要
        InputTableView.dataSource = self
        InputTableView.delegate = self
        
        InputTableView.sectionHeaderHeight = 200
        
        //金額項目に数字入力のみ行える
        NotificationCenter.default.addObserver(self,selector:#selector(textFieldDidChange),name: NSNotification.Name.UITextFieldTextDidChange,object: Money)
        
        //AppDelegateのインスタンスを取得
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //AppDelegateで設定した値をラベルに設定
        textYear.text = appDelegate.year
        textMonth.text = appDelegate.month
        textDay.text = appDelegate.day
        
        testLabel.text = "収入"

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
        
        Money.delegate = self
        Money.inputAccessoryView = toolBar
        
        cost.delegate = self
        cost.inputAccessoryView = toolBar
        
        pickerTextField.delegate = self
        pickerTextField.inputView = pickerView
        pickerTextField.inputAccessoryView = toolBar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
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
        return pickerTextField.text = pickOption[row]
    }
    
    @objc func donePressed(sender: UIBarButtonItem) {
        self.view.endEditing(true)
    }
    
    @objc func canclePressed(sender: UIBarButtonItem) {
        pickerTextField.text = ""
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ Text: UITextField) -> Bool {
        Money.resignFirstResponder()
        cost.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        Money.resignFirstResponder()
        cost.resignFirstResponder()
        self.view.endEditing(true)
    }
    
    
    //セグメントコントロールが押された時のカテゴリの表示の変更，ラベルの変更
    @IBAction func testSegmentControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            pickerTextField.text = ""
            pickOption = ["カテゴリ1", "カテゴリ2", "カテゴリ3", "カテゴリ4", "カテゴリ5"]
            testLabel.text = "収入"
            
        case 1:
            pickerTextField.text = ""
            pickOption = ["テスト1", "テスト2", "テスト3", "テスト4", "テスト5"]
            
            testLabel.text = "支出"
        default:
            print("該当無し")
        }
    }
    
    //CalendarViewContorollerからの値の引き渡し
    override func viewWillAppear(_ animated: Bool) {
        loadView()
        viewDidLoad()
    }
    
    //tableViewCellに表示するためのデータ
//    var moneyTag = ["水道代", "外食", "本代"]
    var moneyTag = [String]()
//    var moneyData = ["800", "3000", "2000"]
//    var moneyCategory = ["光熱費", "生活費", "雑費"]
    var moneyData = [String]()
    var moneyCategory = [String]()
    
    // 日付の取得
    func dates () -> String{
        let date = Date()
        let format: DateFormatter = DateFormatter()
        format.dateFormat = "yyyy年MM月dd日"
        
        let sDate = format.string(from: date)
        return sDate
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
    
    //追加ボタンを押した時の動作
    @IBAction func AddDataBtn(_ sender: UIButton) {
        moneyTag.append(cost.text!)
        moneyData.append(Money.text!)
        moneyCategory.append(pickerTextField.text!)
        
        //AppDelegateのインスタンスを取得
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.Tagtext = cost.text
        appDelegate.Datatext = Money.text
        appDelegate.Categorytext = pickerTextField.text
        
        pickerTextField.text = " "
        Money.text = " "
        cost.text = " "
        //すぐに表示するためにviewcontrollerのリロード
        loadView()
        viewDidLoad()        
    }
    
    //金額項目に数字入力のみにする
    @objc func textFieldDidChange(notification: NSNotification) {
        let textField = notification.object as! UITextField
        guard let text = textField.text else { return }
        guard let intText = Int(text) else { textField.text = ""; return }
    }
}


