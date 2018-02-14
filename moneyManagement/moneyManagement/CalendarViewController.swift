import UIKit
import FSCalendar
import CalculateCalendarLogic
import RealmSwift

class CalendarViewController: UIViewController,FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance {

    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var amount: UILabel!
    
    var incomeData: Results<testincome>!
    var expenceData: Results<testexpence>!
    
    var year = Int()
    var month = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.calendar.dataSource = self
        self.calendar.delegate = self
        
        let date = Date()
        let format: DateFormatter = DateFormatter()
        format.dateFormat = "yyyy"
        year = Int(format.string(from: date))!
        format.dateFormat = "MM"
        month = Int(format.string(from: date))!
        updateData(year: year, month: month)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        if appDelegate.year != "" {
            updateData(year: year, month: month)
        }else {
            let date = Date()
            let format: DateFormatter = DateFormatter()
            format.dateFormat = "yyyy"
            year = Int(format.string(from: date))!
            format.dateFormat = "MM"
            month = Int(format.string(from: date))!
            updateData(year: year, month: month)
        }
    }
    
    fileprivate let gregorian: Calendar = Calendar(identifier: .gregorian)
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    // 祝日判定を行い結果を返すメソッド(True:祝日)
    func judgeHoliday(_ date : Date) -> Bool {
        //祝日判定用のカレンダークラスのインスタンス
        let tmpCalendar = Calendar(identifier: .gregorian)
        
        // 祝日判定を行う日にちの年、月、日を取得
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)
        
        // CalculateCalendarLogic()：祝日判定のインスタンスの生成
        let holiday = CalculateCalendarLogic()
        
        return holiday.judgeJapaneseHoliday(year: year, month: month, day: day)
    }
    // date型 -> 年月日をIntで取得
    func getDay(_ date:Date) -> (Int,Int,Int){
        let tmpCalendar = Calendar(identifier: .gregorian)
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)
        return (year,month,day)
    }
    
    //曜日判定(日曜日:1 〜 土曜日:7)
    func getWeekIdx(_ date: Date) -> Int{
        let tmpCalendar = Calendar(identifier: .gregorian)
        return tmpCalendar.component(.weekday, from: date)
    }
    
    // 土日や祝日の日の文字色を変える
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        //祝日判定をする（祝日は赤色で表示する）
        if self.judgeHoliday(date){
            return UIColor.red
        }
        
        //土日の判定を行う（土曜日は青色、日曜日は赤色で表示する）
        let weekday = self.getWeekIdx(date)
        if weekday == 1 {   //日曜日
            return UIColor.red
        }
        else if weekday == 7 {  //土曜日
            return UIColor.blue
        }
        
        return nil
    }
    
    func calendar(_ calendar:FSCalendar, didSelect date: Date, at monthPosition:FSCalendarMonthPosition){
        let selectDay = getDay(date)
        
        //Appdelegateのインスタンス生成
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.year = String(selectDay.0)
        appDelegate.month = String(selectDay.1)
        appDelegate.day = String(selectDay.2)
        
        year = selectDay.0
        month = selectDay.1
    
        updateData(year: selectDay.0,month: selectDay.1)
    }
    
    func updateData(year: Int, month: Int){
        var sum_i: Int = 0
        var sum_e: Int = 0
        
        do {
            // スキーマバージョンを上げる。デフォルトのスキーマバージョンは0
            let config = Realm.Configuration(schemaVersion: 2)
            Realm.Configuration.defaultConfiguration = config
            
            let realm = try Realm()
            print(Realm.Configuration.defaultConfiguration.fileURL!)
            incomeData = realm.objects(testincome.self).sorted(byKeyPath: "num", ascending: false).filter("year == %@ AND month == %@",year,month)
            
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
        
        do {
            // スキーマバージョンを上げる。デフォルトのスキーマバージョンは0
            let config = Realm.Configuration(schemaVersion: 2)
            Realm.Configuration.defaultConfiguration = config
            
            let realm = try Realm()
            print(Realm.Configuration.defaultConfiguration.fileURL!)
            expenceData = realm.objects(testexpence.self).sorted(byKeyPath: "num", ascending: false).filter("year == %@ AND month == %@",year,month)
            
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
        
        sum_i = incomeData.sum(ofProperty: "data")
        sum_e = expenceData.sum(ofProperty: "data")
        
        amount.text = String(sum_i - sum_e)
        
        if sum_i - sum_e < 0 {
            amount.textColor = UIColor.red
        }else if sum_i - sum_e > 0 {
            amount.textColor = UIColor.blue
        }else {
            amount.textColor = UIColor.black
        }
    }
}

