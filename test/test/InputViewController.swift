//
//  TabViewController.swift
//  
//
//  Created by 内原　朝也 on 2017/12/18.
//

import UIKit
import FSCalendar

class InputViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate{
    
    @IBOutlet weak var Money: UITextField!
    @IBOutlet weak var cost: UITextField!
    @IBOutlet weak var pickerTextField: UITextField!
    
    @IBOutlet weak var testLabel: UILabel!
    
    let pickerView = UIPickerView()
    
    var pickOption = ["カテゴリ1", "カテゴリ2", "カテゴリ3", "カテゴリ4", "カテゴリ5"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
}


