//
//  ViewController.swift
//  リスト
//
//  Created by 照屋健弘 on 2017/12/02.
//  Copyright © 2017年 teruyatakehiro. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
  
  let list = ["雑費","食費","交際費"]
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return list.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    
    return list[row]
  }
  
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    label.text = list[row]
  }
  
  
  

  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var testLabel: UIPickerView!
  
  
    
    override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
      label.text = "選択"
      testLabel.dataSource = self
      testLabel.delegate = self
      
      
  }
  
  
  
  
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

