import UIKit
import FSCalendar
import RealmSwift

class InputViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate, UITabBarDelegate{
    
    @IBOutlet var expenceView: Expence!
    @IBOutlet var incomeView: Income!
    @IBOutlet weak var tableBaseView: UIView!
    @IBOutlet weak var Segment: UISegmentedControl!
    
    @IBOutlet weak var Money: UITextField!
    @IBOutlet weak var cost: UITextField!
    @IBOutlet weak var pickerTextField: UITextField!
    
    @IBOutlet weak var testLabel: UILabel!
    
    @IBOutlet weak var textYear: UILabel!
    @IBOutlet weak var textMonth: UILabel!
    @IBOutlet weak var textDay: UILabel!
    
    let pickerView = UIPickerView()
    var pickOption = [String]()

    var myItem: [incomeData] = []
    var myItem_2: [expenceData] = []
    
    var segCount: Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //収支・支出のテーブルを表示
        incomeView.parent = self
        expenceView.parent = self
        tableBaseView.addSubview(incomeView)
        tableBaseView.addSubview(expenceView)
        testSegmentControl(Segment)
        
        //金額項目に数字入力のみ行える
        NotificationCenter.default.addObserver(self,selector:#selector(textFieldDidChange),name: NSNotification.Name.UITextFieldTextDidChange,object: Money)
        
        
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
        if Segment.selectedSegmentIndex == 0 {
            incomeView.isHidden  = false
            expenceView.isHidden = true
            testLabel.text = "収入"
            pickOption = ["バイト・給料","その他"]
            pickerTextField.text = ""
            segCount = 0
        } else {
            incomeView.isHidden  = true
            expenceView.isHidden = false
            testLabel.text = "支出"
            pickOption = ["食費","日用品","交通費","本・雑誌","携帯電話・インターネット","医療費・医薬品","交際費","家賃","衣類","水道・電気・ガス","その他"]
            pickerTextField.text = ""
            segCount = 1
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        incomeView.frame = tableBaseView.bounds
        expenceView.frame = tableBaseView.bounds
        
        //AppDelegateのインスタンスを取得
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if appDelegate.year == "" {
            textYear.text = dates(c: 1)
            textMonth.text = dates(c: 2)
            textDay.text = dates(c: 3)
        }else {
            //AppDelegateで設定した値をラベルに設定
            textYear.text = appDelegate.year
            textMonth.text = appDelegate.month
            textDay.text = appDelegate.day
        }
        
        let income = Income()
        let expence = Expence()
        incomeView.reloadData()
        expenceView.reloadData()
        income.awakeFromNib()
        expence.awakeFromNib()
        
    }
    
    // 日付の取得
    func dates (c: Int) -> String{
        let date = Date()
        let format: DateFormatter = DateFormatter()
        format.dateFormat = "yyyy年MM月dd日"
        var sDate = format.string(from: date)
        
        if c ==  0{
            format.dateFormat = "yyyy年MM月dd日"
            sDate = format.string(from: date)
            return sDate
        }else if c == 1 {
            format.dateFormat = "yyyy"
            sDate = format.string(from: date)
            return sDate
        }else if c == 2 {
            format.dateFormat = "MM"
            sDate = format.string(from: date)
            return sDate
        }else if c == 3 {
            format.dateFormat = "dd"
            sDate = format.string(from: date)
            return sDate
        }
        return sDate
    }
    
    //データベースから取得したデータの更新
//    override func viewWillAppear(_ animated: Bool) {
//        let income = Income()
//        let expence = Expence()
//        incomeView.reloadData()
//        expenceView.reloadData()
//        income.awakeFromNib()
//        expence.awakeFromNib()
//    }
    
    
    //追加ボタンを押した時の動作
    @IBAction func AddDataBtn(_ sender: UIButton) {
        if Money.text != "" && cost.text != "" && pickerTextField.text != "" {
            if segCount == 0{
                //収入用データベースへのデータ挿入
                let incomedata = incomeData()
                incomedata.data = Int(Money.text!)!
                incomedata.label = cost.text!
                incomedata.Category = pickerTextField.text!
//                incomedata.year = Int(textYear.text!)!
//                incomedata.month = Int(textMonth.text!)!
//                incomedata.day = Int(textDay.text!)!
                incomedata.save()
            
                Money.text=""
                cost.text=""
                pickerTextField.text = ""
            
                let realm = try! Realm()
                let myObj = realm.objects(incomeData.self)
                myItem = []
                myObj.forEach{item in
                    myItem.append(item)
                }
                let income = Income()
                incomeView.reloadData()
                income.awakeFromNib()
            }else if segCount == 1{
                //支出用データベースへのデータ挿入
                let expencedata = expenceData()
                expencedata.data = Int(Money.text!)!
                expencedata.label = cost.text!
                expencedata.Category = pickerTextField.text!
//                expencedata.year = Int(textYear.text!)!
//                expencedata.month = Int(textMonth.text!)!
//                expencedata.day = Int(textDay.text!)!
                expencedata.save()
                
                Money.text=""
                cost.text=""
                pickerTextField.text = ""
                
                let realm = try! Realm()
                let myObj = realm.objects(expenceData.self)
                myItem_2 = []
                myObj.forEach{item in
                    myItem_2.append(item)
                }
                let expence = Expence()
                expenceView.reloadData()
                expence.awakeFromNib()
            }
        }
    }
    
    //金額項目に数字入力のみにする
    @objc func textFieldDidChange(notification: NSNotification) {
        let textField = notification.object as! UITextField
        guard let text = textField.text else { return }
        guard Int(text) != nil else { textField.text = ""; return }
    }
}


